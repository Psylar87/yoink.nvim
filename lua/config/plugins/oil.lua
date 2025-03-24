return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    skip_confrim_from_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = 'rounded',
      win_options = {
        winblend = 10,
      },
    },
    keymaps = {
      ['q'] = 'actions.close',
      ['<Esc>'] = 'actions.close',
    },
  },
  lazy = false,
  config = function(_, opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '-', function()
      require('oil').open_float()
    end, { desc = 'Open parent directory in float' })
  end,
}
