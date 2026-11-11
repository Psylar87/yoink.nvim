local M = {}
local timeout_ms = 1000

local function warn(reason)
  vim.notify('Go import organization: ' .. tostring(reason), vim.log.levels.WARN)
end

---@param client vim.lsp.Client
---@param command lsp.Command
---@param bufnr integer
local function execute_command(client, command, bufnr)
  local handled_locally = client.commands[command.command] or vim.lsp.commands[command.command]
  local completed = false
  local command_error
  client:exec_cmd(command, { bufnr = bufnr }, function(err)
    command_error = err
    completed = true
  end)

  -- Server commands can apply workspace edits: wait for them before the write completes.
  -- Local command handlers run directly and do not invoke exec_cmd's response handler.
  if not handled_locally and not vim.wait(timeout_ms, function()
    return completed
  end) then
    warn('command timed out: ' .. command.command)
  elseif command_error then
    warn(command_error.message)
  end
end

---@param client vim.lsp.Client
---@param bufnr integer
function M.organize_imports(client, bufnr)
  if client:is_stopped() or not client.attached_buffers[bufnr] then
    return
  end

  -- An unavailable server or a failed action should not prevent saving the file.
  local ok, failure = pcall(function()
    ---@type lsp.CodeActionParams
    local params = {
      textDocument = vim.lsp.util.make_text_document_params(bufnr),
      range = { start = { line = 0, character = 0 }, ['end'] = { line = 0, character = 0 } },
      context = { diagnostics = {}, only = { 'source.organizeImports' } },
    }
    local response, request_error = client:request_sync('textDocument/codeAction', params, timeout_ms, bufnr)
    if not response then
      warn(request_error or 'request failed')
      return
    end
    if response.err then
      warn(response.err.message)
      return
    end
    if response.result == nil or response.result == vim.NIL then
      return
    end

    ---@type (lsp.Command|lsp.CodeAction)[]
    local actions = response.result
    for _, action in ipairs(actions) do
      if type(action.command) == 'string' then
        ---@cast action lsp.Command
        execute_command(client, action, bufnr)
      else
        ---@cast action lsp.CodeAction
        if not action.disabled then
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end
          if action.command then
            execute_command(client, action.command, bufnr)
          end
        end
      end
    end
  end)
  if not ok then
    warn(failure)
  end
end

return M
