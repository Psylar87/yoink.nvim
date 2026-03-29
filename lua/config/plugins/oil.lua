return {
  'stevearc/oil.nvim',
  keys = {
    {
      '-',
      function()
        require('oil').open_float()
      end,
      desc = 'Open parent directory in float',
    },
    {
      '_',
      function()
        require('oil').open_float(nil, { preview = { vertical = true } })
      end,
      desc = 'Open parent directory in float with preview',
    },
  },
  cmd = { 'Oil' },
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
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
        winblend = 30,
      },
      preview_split = 'right',
    },
    keymaps = {
      ['<Esc>'] = 'actions.close',
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)
  end,
}
