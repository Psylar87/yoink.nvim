return {
  {
    'romgrk/barbar.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    init = function()
      vim.g.barbar_auto_setup = false
      vim.opt.sessionoptions:append 'globals'

      vim.api.nvim_create_autocmd('User', {
        pattern = 'SessionSavePre',
        callback = function() end,
      })
    end,
    opts = {
      -- Appearance
      animation = true,
      auto_hide = 1, -- Hide when only one buffer is open
      tabpages = true,
      clickable = true,
      focus_on_close = 'previous',

      -- Hide certain buffers
      exclude_ft = { 'NvimTree', 'help', 'qf' },
      exclude_name = { '[dap-repl]' },

      icons = {
        preset = 'default',
        buffer_index = true,
        filetype = {
          enabled = true,
          custom_colors = true,
        },
        separator = {
          left = '▎',
          right = '',
        },
        separator_at_end = true,

        modified = {
          button = '●',
        },
        pinned = {
          button = '󰐃',
          filename = true,
        },
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.INFO] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
        },
        gitsigns = {
          added = { enabled = true, icon = '+' },
          changed = { enabled = true, icon = '~' },
          deleted = { enabled = true, icon = '-' },
        },

        current = {
          buffer_index = true,
          button = '',
        },
        inactive = {
          button = '×',
          separator = { left = '▎', right = '' },
        },
        visible = {
          modified = { buffer_number = false },
        },
      },

      -- Buffer appearance
      maximum_padding = 2,
      minimum_padding = 1,
      maximum_length = 30,

      sidebar_filetypes = {
        NvimTree = true,
      },

      sort = {
        ignore_case = true,
      },

      no_name_title = '[No Name]',
    },
    config = function(_, opts)
      require('barbar').setup(opts)

      pcall(function()
        vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#ffffff', bg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { fg = '#7aa2f7', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#e0af68', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#7aa2f7', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferInactive', { fg = '#737aa2', bg = '#16161e' })
        vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#e0af68', bg = '#16161e' })
        vim.api.nvim_set_hl(0, 'BufferTabpageFill', { fg = '#16161e', bg = '#16161e' })
      end)

      local nvim_tree_events = require('nvim-tree.api').events
      local Event = nvim_tree_events.Event
      local barbar_api = require 'barbar.api'

      nvim_tree_events.subscribe(Event.TreeOpen, function()
        barbar_api.set_offset(vim.fn.winwidth(0), 'NvimTree')
      end)

      nvim_tree_events.subscribe(Event.TreeClose, function()
        barbar_api.set_offset(0)
      end)

      nvim_tree_events.subscribe(Event.Resize, function(size)
        barbar_api.set_offset(size, 'NvimTree')
      end)
    end,
  },
}
