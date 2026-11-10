local function open_directory(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.notify('Directory unavailable: ' .. path .. '; opening home instead', vim.log.levels.INFO)
    path = vim.env.HOME
  end
  -- Pass the starting directory directly, preserving the editor's working directory.
  require('yazi').yazi(nil, path)
end

return {
  ---@type LazyPluginSpec
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
          open_directory(vim.env.HOME)
        end,
        desc = 'Open yazi in home directory',
      },
      {
        '<leader>yn',
        function()
          open_directory(vim.fn.stdpath 'config')
        end,
        desc = 'Open yazi in neovim config directory',
      },
      {
        '<leader>yw',
        function()
          open_directory(vim.fs.joinpath(vim.env.HOME, 'Downloads'))
        end,
        desc = 'Open yazi in Downloads directory',
      },
      {
        '<leader>yk',
        function()
          open_directory(vim.fs.joinpath(vim.env.HOME, 'Desktop'))
        end,
        desc = 'Open yazi in Desktop directory',
      },
      {
        '<leader>yc',
        function()
          open_directory(vim.fs.joinpath(vim.env.HOME, '.config'))
        end,
        desc = 'Open yazi in .config directory',
      },
    },
    opts = {
      open_for_directories = false,
      floating_window_scaling_factor = { width = 0.9, height = 0.8 },
      yazi_floating_window_border = 'rounded',
      keymaps = {
        show_help = '<f1>',
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
