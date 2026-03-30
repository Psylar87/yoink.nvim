-- Track startup time
local startup_time = vim.fn.reltime()

-- Set leaders before loading mappings/plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Temporary Neovim 0.12 markdown Treesitter compatibility guard
if vim.fn.has 'nvim-0.12' == 1 and vim.treesitter and vim.treesitter.start then
  local treesitter_start = vim.treesitter.start

  vim.treesitter.start = function(bufnr, lang)
    local target_buf = bufnr or 0
    if target_buf == 0 then
      target_buf = vim.api.nvim_get_current_buf()
    end

    local target_lang = lang or vim.bo[target_buf].filetype
    if target_lang == 'markdown' or target_lang == 'markdown_inline' then
      return false
    end

    return treesitter_start(bufnr, lang)
  end
end

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
