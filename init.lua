-- Add startup time profiling
local startup_time = vim.fn.reltime()

-- Add better error handling for requires
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error loading %s: %s', module, result), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Core configuration
for _, module in ipairs { 'config.mappings', 'config.opts', 'config.lazy' } do
  safe_require(module)
end

-- Improved nvim-tree autostart
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Check if we're not opening a file
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        local tree_api = require 'nvim-tree.api'
        if tree_api then
          tree_api.tree.open()
          vim.cmd 'wincmd p'
        end
      end, 100)
    end
  end,
})

-- Report startup time
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local elapsed = vim.fn.reltimefloat(vim.fn.reltime(startup_time)) * 1000
    vim.notify(string.format('Neovim loaded in %.2f ms', elapsed))
  end,
})
