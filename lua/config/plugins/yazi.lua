return {
  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<leader>-',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-y>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
      {
        '<leader>yh',
        function()
          vim.cmd.lcd(vim.env.HOME)
          vim.cmd 'Yazi cwd'
        end,
        desc = 'Open yazi in home directory',
      },
      {
        '<leader>yn',
        function()
          vim.cmd.lcd(vim.fn.stdpath 'config')
          vim.cmd 'Yazi cwd'
        end,
        desc = 'Open yazi in neovim config directory',
      },
      {
        '<leader>yw',
        function()
          vim.cmd.lcd(vim.fs.joinpath(vim.env.HOME, 'Downloads'))
          vim.cmd 'Yazi cwd'
        end,
        desc = 'Open yazi in Downloads directory',
      },
      {
        '<leader>yk',
        function()
          vim.cmd.lcd(vim.fs.joinpath(vim.env.HOME, 'Desktop'))
          vim.cmd 'Yazi cwd'
        end,
        desc = 'Open yazi in Desktop directory',
      },
      {
        '<leader>yc',
        function()
          vim.cmd.lcd(vim.fs.joinpath(vim.env.HOME, '.config'))
          vim.cmd 'Yazi cwd'
        end,
        desc = 'Open yazi in .config directory',
      },
    },
    opts = {
      open_for_directories = false,
      popup = {
        size = {
          width = '90%',
          height = '80%',
        },
        position = '50%',
        border = 'rounded',
      },
      keymaps = {
        show_help = '<f1>',
        parent_dir = 'h',
        close = '<esc>',
        refresh = '<c-r>',
        toggle_hidden = '.',
      },
      preview = {
        enabled = true,
        show_line_numbers = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'yazi',
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
  },
}
