return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          --          adaptive_size = true, -- Automatically adjusts the width to fit file names
        },
      }
      -- Auto open nvim-tree when Neovim starts
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          require('nvim-tree.api').tree.open()
        end,
      })
    end,
  },
}
