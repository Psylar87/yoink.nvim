return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Use win instead of window (fixed deprecated option)
      win = {
        border = 'none', -- none, single, double, shadow
        padding = { 1, 1, 1, 1 },
      },

      -- Add sorting options
      sort = {
        enable = true, -- enable sorting
        order = 'local', -- order mappings by 'local', 'group', or 'alpha'
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        -- Add more key groups to better organize your mappings
        { '<leader>f', group = '[F]ind/Files' },
        { '<leader>g', group = '[G]it' },
        { '<leader>b', group = '[B]uffers' },

        -- Add groups for some of the overlapping keys from health check
        { 'g', group = 'Go to/LSP/Comment' },
        { 's', group = 'Surround' },
        { '<leader>\\e', group = 'Nvimtree' },
      },

      -- Add ignore patterns for overlapping keymaps
      ignore = {
        -- Ignore specific buffer types
        buftypes = { 'nofile', 'prompt', 'help' },
        -- Ignore specific filetypes
        filetypes = { 'TelescopePrompt' },
      },

      -- Add plugins section for specific plugin configurations
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- Add presets for improved visibility of certain key groups
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },

      -- Add key timeout settings
      timeout = {
        timeout = 300, -- timeout in ms
        trigger_on_keys = true, -- automatically show menu when typing a prefix key
      },
    },
  },
}
