return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    skip_confrim_from_simple_edits = false,
    natural_order = 'fast',
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 10,
      max_width = 0.6,
      max_height = 0,
      border = 'rounded',
      win_options = {
        winblend = 10,
      },
      preview_split = 'right',
    },
    keymaps = {
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
