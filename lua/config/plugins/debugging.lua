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
    local status_dap, dap = pcall(require, 'dap')
    if not status_dap then
      vim.notify('DAP not found', vim.log.levels.ERROR)
      return
    end

    local status_dapui, dapui = pcall(require, 'dapui')
    if not status_dapui then
      vim.notify('DAP UI not found', vim.log.levels.ERROR)
      return
    end

    -- Setup components
    dapui.setup {
      -- Custom UI layout if desired
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
    }

    -- Language-specific setups
    require('dap-go').setup()

    if pcall(require, 'dap-python') then
      require('dap-python').setup 'python' -- Use system Python or specify path
    end

    -- Virtual text for debugging (if installed)
    if pcall(require, 'nvim-dap-virtual-text') then
      require('nvim-dap-virtual-text').setup()
    end

    -- Mason integration
    require('mason-nvim-dap').setup {
      ensure_installed = { 'python', 'delve', 'codelldb' },
      automatic_installation = true,
    }

    -- UI auto-open/close
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

    -- Enhanced keymappings
    vim.keymap.set('n', '<Leader>bt', function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>bc', function()
      dap.continue()
    end)
    vim.keymap.set('n', '<Leader>bx', function()
      dap.terminate()
    end)
    vim.keymap.set('n', '<Leader>bo', function()
      dap.step_over()
    end)
    vim.keymap.set('n', '<Leader>bi', function()
      dap.step_into()
    end)
    vim.keymap.set('n', '<Leader>bu', function()
      dap.step_out()
    end)
    vim.keymap.set('n', '<Leader>br', function()
      dap.restart()
    end)
    vim.keymap.set('n', '<Leader>bC', function()
      vim.ui.input({ prompt = 'Condition: ' }, function(condition)
        if condition then
          dap.set_breakpoint(condition)
        end
      end)
    end)
    vim.keymap.set('n', '<Leader>bv', function()
      dapui.eval()
    end)
  end,
}
