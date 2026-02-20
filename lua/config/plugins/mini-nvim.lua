return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Utility function to define highlight groups if missing
      local function ensure_hl_group(name, opts)
        if vim.fn.hlID(name) == 0 then
          vim.api.nvim_set_hl(0, name, opts)
        end
      end

      -- Detect if 'nvim-web-devicons' plugin is loaded (as proxy for Nerd Font support)
      vim.g.have_nerd_font = pcall(require, 'nvim-web-devicons')

      -- Setup mini.ai for better text objects
      require('mini.ai').setup {
        n_lines = 300, -- balanced for performance and functionality
      }

      -- Setup mini.surround with intuitive mappings
      require('mini.surround').setup {
        n_lines = 100,
        highlight_duration = 500,
        mappings = {
          add = 'sa',
          delete = 'sd',
          replace = 'sr',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          update_n_lines = 'sn',
        },
      }

      -- Auto-pairs for brackets, quotes, etc.
      require('mini.pairs').setup()

      -- Smart commenting
      require('mini.comment').setup {
        options = {
          custom_commentstring = nil,
          ignore_blank_line = false,
          start_of_line = false,
          pad_comment_parts = true,
        },
      }

      -- Indent guides with minimal animation and clear symbol
      require('mini.indentscope').setup {
        symbol = '│',
        options = {
          try_as_border = true,
          indent_at_cursor = true,
          border = 'both',
        },
        draw = {
          delay = 100,
          animation = require('mini.indentscope').gen_animation.none(),
        },
      }

      -- Highlight word under cursor
      require('mini.cursorword').setup()

      -- Move lines and selections with Alt + h/j/k/l (ensure terminal supports these)
      require('mini.move').setup {
        mappings = {
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }

      -- Buffer removal without closing window
      require('mini.bufremove').setup()

      -- Jump anywhere in visible text
      require('mini.jump').setup()

      -- Define fallback highlight groups for statusline if not defined
      ensure_hl_group('MiniStatuslineDevinfo', { fg = '#a0a1a7', bg = 'NONE' })
      ensure_hl_group('MiniStatuslineFilename', { fg = '#61afef', bg = 'NONE', bold = true })
      ensure_hl_group('MiniStatuslineFileinfo', { fg = '#abb2bf', bg = 'NONE' })

      -- Setup statusline with icons and sensible truncations
      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 80 }
            local git = statusline.section_git { trunc_width = 50 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 50 }
            local filename = statusline.section_filename { trunc_width = 80 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 60 }
            local location = '%2l:%-2v'

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<', -- Truncate left if needed
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- Right align
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
      }

      -- Additional mini.nvim modules with default setups
      require('mini.bracketed').setup()
      require('mini.clue').setup()
      require('mini.hipatterns').setup()
      require('mini.splitjoin').setup()
      require('mini.visits').setup()
    end,
  },
}
