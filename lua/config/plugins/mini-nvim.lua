return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        n_lines = 100,
        highlight_duration = 500,
        mappings = {
          add = 'sa', -- Add surrounding
          delete = 'sd', -- Delete surrounding
          replace = 'sr', -- Replace surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          update_n_lines = 'sn', -- Update `n_lines`
        },
      }

      -- Auto-pair brackets, quotes, etc.
      require('mini.pairs').setup()

      -- Smart commenting functionality
      require('mini.comment').setup {
        options = {
          custom_commentstring = nil,
          ignore_blank_line = false,
          start_of_line = false,
          pad_comment_parts = true,
        },
      }

      -- Visual guides for indentation
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

      -- Move lines and blocks of text
      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',
          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      }

      -- Better buffer removal
      require('mini.bufremove').setup()

      -- Jump to any position in visible text
      require('mini.jump').setup()

      -- Statusline configuration
      local statusline = require 'mini.statusline'
      statusline.setup {
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = true,
        content = {
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local git = statusline.section_git { trunc_width = 75 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            local filename = statusline.section_filename { trunc_width = 140 }
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
            local location = '%2l:%-2v'

            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
      }

      -- NEW MODULES

      -- Bracketed navigation
      require('mini.bracketed').setup()

      -- Show next key clues
      require('mini.clue').setup()

      -- Highlight patterns in text
      require('mini.hipatterns').setup()

      -- Split and join arguments
      require('mini.splitjoin').setup()

      -- Track file visits
      require('mini.visits').setup()

      -- KEYMAPS
      vim.keymap.set('n', '<leader>bd', function()
        require('mini.bufremove').delete()
      end, { desc = 'Delete buffer' })

      vim.keymap.set('n', 'gS', function()
        require('mini.splitjoin').toggle()
      end, { desc = 'Toggle split/join' })
    end,
  },
}
