-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- TODO: Add Toggle Terminal
return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
    --:
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  {
    'romgrk/barbar.nvim', -- Provides tab for buffers
    version = '*',
  },
  {
    -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function()
      require('Comment').setup() -- Needed to set default mappings
    end,
  },
  -- Themes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          barbar = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      -- Control + J to accept completion
      vim.cmd [[imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")]]
      vim.g.copilot_no_tab_map = true
    end,
  },
}
