return {
  'mfussenegger/nvim-dap',
  keys = {
    {
      '<Leader>bt',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle breakpoint',
    },
    {
      '<Leader>bc',
      function()
        require('dap').continue()
      end,
      desc = 'Continue debugging',
    },
    {
      '<Leader>bx',
      function()
        require('dap').terminate()
      end,
      desc = 'Terminate debugging',
    },
    {
      '<Leader>bo',
      function()
        require('dap').step_over()
      end,
      desc = 'Step over',
    },
    {
      '<Leader>bi',
      function()
        require('dap').step_into()
      end,
      desc = 'Step into',
    },
    {
      '<Leader>bu',
      function()
        require('dap').step_out()
      end,
      desc = 'Step out',
    },
    {
      '<Leader>br',
      function()
        require('dap').restart()
      end,
      desc = 'Restart debugging',
    },
    {
      '<Leader>bC',
      function()
        vim.ui.input({ prompt = 'Condition: ' }, function(condition)
          if condition then
            require('dap').set_breakpoint(condition)
          end
        end)
      end,
      desc = 'Set conditional breakpoint',
    },
    {
      '<Leader>bv',
      function()
        require('dapui').eval()
      end,
      desc = 'Evaluate expression',
    },
  },
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

  end,
}
