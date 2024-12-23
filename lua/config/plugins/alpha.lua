return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set header
    dashboard.section.header.val = {
      [[     .-') _     ('-.                      (`-.              _   .-')    ]],
      [[    ( OO ) )  _(  OO)                   _(OO  )_           ( '.( OO )_  ]],
      [[,--./ ,--,'  (,------.  .-'),-----. ,--(_/   ,. \  ,-.-')   ,--.   ,--.)]],
      [[|   \ |  |\   |  .---' ( OO'  .-.  '\   \   /(__/  |  |OO)  |   `.'   | ]],
      [[|    \|  | )  |  |     /   |  | |  | \   \ /   /   |  |  \  |         | ]],
      [[|  .     |/  (|  '--.  \_) |  |\|  |  \   '   /,   |  |(_/  |  |'.'|  | ]],
      [[|  |\    |    |  .--'    \ |  | |  |   \     /__) ,|  |_.'  |  |   |  | ]],
      [[|  | \   |    |  `---.    `'  '-'  '    \   /    (_|  |     |  |   |  | ]],
      [[`--'  `--'    `------'      `-----'      `-'       `--'     `--'   `--' ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('C n', '  > Toggle file explorer', '<cmd>NvimTreeToggle<CR>'),
      dashboard.button('SPC sf', '󰱼  > Find File', '<cmd>Telescope find_files<CR>'),
      dashboard.button('SPC sn', '⚙︎ > Search Nvim Config', '<cmd>Telescope find_files cwd=~/.config/nvim<CR>'),
      dashboard.button('A t', '💻 > Toggle Terminal', '<cmd>split term://$SHELL<CR>'),
      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
