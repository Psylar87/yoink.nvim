--------------------------------------------------------------------------------
--  Custom Mappings and Options
--------------------------------------------------------------------------------
require 'config.mappings'
require 'config.opts'
require 'config.lazy'
--------------------------------------------------------------------------------
-- Example Kickstart "Indent line" plugin
-- (or you could consider 'lukas-reineke/indent-blankline.nvim')
--------------------------------------------------------------------------------
require 'kickstart.plugins.indent_line'

-- Auto-open nvim-tree on startup while preserving dashboard
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- This delay ensures the dashboard loads first
    vim.defer_fn(function()
      -- Open the tree
      require('nvim-tree.api').tree.open()
      -- Return focus to the main window (dashboard)
      vim.cmd 'wincmd p'
    end, 100)
  end,
})
