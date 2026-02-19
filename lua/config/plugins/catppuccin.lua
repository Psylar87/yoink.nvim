return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          telescope = true,
          barbar = true,
          which_key = true,
          snacks = true,
          gitsigns = true,
          noice = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
