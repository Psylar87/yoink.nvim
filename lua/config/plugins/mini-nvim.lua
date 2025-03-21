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
      require('mini.surround').setup()

      -- Auto-pair brackets, quotes, etc.
      -- Automatically closes brackets and quotes as you type
      require('mini.pairs').setup()

      -- Smart commenting functionality
      -- gcc - Toggle line comment
      -- gc{motion} - Toggle comment for motion
      require('mini.comment').setup()

      -- Visual guides for indentation
      -- Shows vertical lines for each indentation level
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }

      -- Highlight word under cursor
      -- Automatically highlights all instances of the word under cursor
      require('mini.cursorword').setup()

      -- Move lines and blocks of text
      -- Alt+j/k to move lines up/down in normal and visual mode
      -- Alt+h/l to move character/selection left/right
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

      -- Better buffer removal (doesn't mess up layout)
      -- Use with keymaps like:
      -- vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete() end)
      require('mini.bufremove').setup()

      -- Jump to any position in visible text
      -- Press f/F followed by a character to jump to it
      require('mini.jump').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- File explorer (optional, if you don't use another file explorer)
      -- require('mini.files').setup()

      -- Animated scrolling (optional, for smooth scrolling)
      -- require('mini.animate').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
