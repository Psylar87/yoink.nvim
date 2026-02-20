return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local ok, dap = pcall(require, 'dap')
    if not ok then
      vim.notify('DAP not found', vim.log.levels.ERROR)
      return
    end

    local ok_ui, dapui = pcall(require, 'dapui')
    if not ok_ui then
      vim.notify('DAP UI not found', vim.log.levels.ERROR)
      return
    end

    dapui.setup()

    require('dap-go').setup()

    local ok_py, dap_python = pcall(require, 'dap-python')
    if ok_py then
      dap_python.setup 'python'
    end

    local ok_vt, dap_vt = pcall(require, 'nvim-dap-virtual-text')
    if ok_vt then
      dap_vt.setup { enabled = true }
    end

    require('mason-nvim-dap').setup {
      ensure_installed = { 'python', 'delve', 'codelldb' },
      automatic_installation = true,
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<Leader>bt', function()
      dap.toggle_breakpoint()
    end, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<Leader>bc', function()
      dap.continue()
    end, { desc = 'Continue debugging' })
    vim.keymap.set('n', '<Leader>bx', function()
      dap.terminate()
    end, { desc = 'Terminate debugging' })
    vim.keymap.set('n', '<Leader>bo', function()
      dap.step_over()
    end, { desc = 'Step over' })
    vim.keymap.set('n', '<Leader>bi', function()
      dap.step_into()
    end, { desc = 'Step into' })
    vim.keymap.set('n', '<Leader>bu', function()
      dap.step_out()
    end, { desc = 'Step out' })
    vim.keymap.set('n', '<Leader>br', function()
      dap.restart()
    end, { desc = 'Restart debugging' })
    vim.keymap.set('n', '<Leader>bC', function()
      vim.ui.input({ prompt = 'Condition: ' }, function(condition)
        if condition then
          dap.set_breakpoint(condition)
        end
      end)
    end, { desc = 'Set conditional breakpoint' })
    vim.keymap.set('n', '<Leader>bv', function()
      dapui.eval()
    end, { desc = 'Evaluate expression' })
  end,
}
