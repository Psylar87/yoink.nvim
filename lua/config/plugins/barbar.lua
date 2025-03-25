return {
  {
    'romgrk/barbar.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- For file icons
      'lewis6991/gitsigns.nvim', -- Required for git integration
    },
    init = function()
      vim.g.barbar_auto_setup = false -- Disable auto-setup to use custom config

      -- Fix for sessionoptions syntax (use : instead of space)
      vim.opt.sessionoptions:append 'globals' -- For session support

      -- Add autocmd for session save
      vim.api.nvim_create_autocmd('User', {
        pattern = 'SessionSavePre',
        callback = function()
          -- barbar will handle saving buffer state
        end,
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
      exclude_ft = { 'NvimTree', 'help', 'qf' }, -- Removed 'Outline' if not using it
      exclude_name = { '[dap-repl]' },

      -- Icons configuration
      icons = {
        -- Use a preset for a predefined look
        preset = 'default',

        -- Buffer index display
        buffer_index = true,

        -- File icons
        filetype = {
          enabled = true,
          custom_colors = true,
        },

        -- Separators
        separator = {
          left = '▎',
          right = '',
        },
        separator_at_end = true, -- Moved out of separator table

        -- Modified indicator
        modified = {
          button = '●',
        },

        -- Pinned indicator
        pinned = {
          button = '󰐃',
          filename = true,
        },

        -- Diagnostics integration
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.INFO] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
        },

        -- Git integration - make sure gitsigns is loaded
        gitsigns = {
          added = { enabled = true, icon = '+' },
          changed = { enabled = true, icon = '~' },
          deleted = { enabled = true, icon = '-' },
        },

        -- Customize appearance for different buffer states
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

      -- NvimTree integration
      sidebar_filetypes = {
        NvimTree = { text = 'File Explorer' }, -- Simplified
      },

      -- Sorting options
      sort = {
        ignore_case = true,
      },

      -- No name buffer title
      no_name_title = '[No Name]',
    },
    config = function(_, opts)
      -- Make sure barbar is properly loaded before setting up
      local ok, barbar = pcall(require, 'barbar')
      if not ok then
        vim.notify('barbar.nvim not found', vim.log.levels.ERROR)
        return
      end

      -- Setup barbar with error handling
      pcall(barbar.setup, opts)

      -- Custom highlight groups for barbar (wrapped in pcall for safety)
      pcall(function()
        vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#ffffff', bg = '#1a1b26', bold = true })
        vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { fg = '#7aa2f7', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#e0af68', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#7aa2f7', bg = '#1a1b26' })
        vim.api.nvim_set_hl(0, 'BufferInactive', { fg = '#737aa2', bg = '#16161e' })
        vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#e0af68', bg = '#16161e' })
        vim.api.nvim_set_hl(0, 'BufferTabpageFill', { fg = '#16161e', bg = '#16161e' })
      end)

      -- NvimTree integration with error handling
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'NvimTree',
        callback = function()
          -- Ensure NvimTree is properly integrated with barbar
          pcall(function()
            local api = require 'barbar.api'
            if api and api.update then
              api.update()
            end
          end)
        end,
      })
    end,
  },
}
