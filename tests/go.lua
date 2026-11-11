-- Run from the configuration root: nvim --headless -u NONE -i NONE -l tests/go.lua
vim.opt.rtp:prepend(vim.fn.getcwd())

local organize_imports = require('config.go').organize_imports
local original_notify = vim.notify
local warnings = {}
vim.notify = function(message, level)
  assert(level == vim.log.levels.WARN)
  warnings[#warnings + 1] = message
end

local function main()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(bufnr, vim.fn.tempname() .. '.go')
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'package main', '// 😀 obsolete' })
  -- The buffer being saved need not be the current buffer (for example, :wall).
  assert(vim.api.nvim_get_current_buf() ~= bufnr)
  local uri = vim.uri_from_bufnr(bufnr)
  local commands = {}
  local client = {
    attached_buffers = { [bufnr] = true },
    offset_encoding = 'utf-16',
    commands = {},
    is_stopped = function()
      return false
    end,
    request_sync = function(_, method, params, timeout_ms, target)
      assert(method == 'textDocument/codeAction' and target == bufnr)
      assert(timeout_ms == 1000 and params.textDocument.uri == uri)
      assert(vim.deep_equal(params.context.diagnostics, {}))
      assert(vim.deep_equal(params.context.only, { 'source.organizeImports' }))
      return {
        result = {
          {
            title = 'Edit and command',
            edit = {
              changes = {
                [uri] = { { range = { start = { line = 1, character = 6 }, ['end'] = { line = 1, character = 14 } }, newText = 'kept' } },
              },
            },
            command = { title = 'Finish imports', command = 'gopls.finish' },
          },
          { title = 'Standalone command', command = 'gopls.organize' },
          { title = 'Disabled action', disabled = { reason = 'Unavailable' }, command = { title = 'Skip', command = 'gopls.skip' } },
        },
      }
    end,
    exec_cmd = function(_, command, context, callback)
      assert(context.bufnr == bufnr)
      vim.defer_fn(function()
        commands[#commands + 1] = command.command
        callback(nil)
      end, 10)
    end,
  }

  organize_imports(client, bufnr)
  assert(#warnings == 0, vim.inspect(warnings))
  assert(vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1] == '// 😀 kept', 'Workspace edits must use the client encoding')
  assert(vim.deep_equal(commands, { 'gopls.finish', 'gopls.organize' }), 'Both command shapes must finish before returning')

  local function expect_warning(request, expected)
    warnings = {}
    client.request_sync = request
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    organize_imports(client, bufnr)
    assert(#warnings == 1 and warnings[1]:find(expected, 1, true), vim.inspect(warnings))
    assert(vim.deep_equal(before, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)))
  end

  expect_warning(function()
    return nil, 'timeout'
  end, 'timeout')
  expect_warning(function()
    return { err = { message = 'Server failure' } }
  end, 'Server failure')
  expect_warning(function()
    error 'Transport failure'
  end, 'Transport failure')

  warnings = {}
  client.request_sync = function()
    return { result = vim.NIL }
  end
  organize_imports(client, bufnr)
  assert(#warnings == 0, 'A null result means no actions')

  client.request_sync = function()
    return { result = { { title = 'Command error', command = 'gopls.error' } } }
  end
  client.exec_cmd = function(_, _, _, callback)
    callback { message = 'Command failure' }
  end
  organize_imports(client, bufnr)
  assert(#warnings == 1 and warnings[1]:find('Command failure', 1, true))

  warnings = {}
  client.exec_cmd = function() end
  organize_imports(client, bufnr)
  assert(#warnings == 1 and warnings[1]:find('command timed out', 1, true))

  warnings = {}
  local local_command_ran = false
  client.commands['gopls.error'] = function()
    local_command_ran = true
  end
  client.exec_cmd = function(_, command)
    client.commands[command.command]()
  end
  organize_imports(client, bufnr)
  assert(local_command_ran and #warnings == 0, 'Local handlers do not invoke a response callback')

  client.request_sync = function()
    error 'Detached or stopped clients must not receive requests'
  end
  client.attached_buffers[bufnr] = nil
  organize_imports(client, bufnr)
  client.attached_buffers[bufnr] = true
  client.is_stopped = function()
    return true
  end
  organize_imports(client, bufnr)
  assert(#warnings == 0)

  vim.api.nvim_buf_delete(bufnr, { force = true })
end

local ok, err = xpcall(main, debug.traceback)
vim.notify = original_notify
if not ok then
  io.stderr:write(err .. '\n')
  vim.cmd 'cquit 1'
end
print 'Go imports: request shape, UTF-16 edits, command responses, timeouts, and detached-client checks passed'
