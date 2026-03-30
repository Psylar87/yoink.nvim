-- Track startup time
local startup_time = vim.fn.reltime()

-- Set leaders before loading mappings/plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Wrap requires with notifications on failure
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error loading %s: %s', module, result), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Core configuration
for _, module in ipairs { 'config.opts', 'config.mappings', 'config.lazy' } do
  safe_require(module)
end

-- Open nvim-tree on empty start
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Only run when no file arguments were passed
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        local ok = pcall(vim.cmd, 'NvimTreeOpen')
        if ok then
          vim.cmd 'wincmd p'
        end
      end, 100)
    end
  end,
})

-- Report startup time once UI is ready
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local elapsed = vim.fn.reltimefloat(vim.fn.reltime(startup_time)) * 1000
    vim.notify(string.format('Neovim loaded in %.2f ms', elapsed))
  end,
})
