--------------------------------------------------------------------------------
-- Leader Key Configuration
--------------------------------------------------------------------------------
-- Set <space> as the leader key (must be before plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

--------------------------------------------------------------------------------
-- Performance Optimizations
--------------------------------------------------------------------------------
vim.opt.redrawtime = 1500
vim.opt.synmaxcol = 200
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

--------------------------------------------------------------------------------
-- UI Configuration
--------------------------------------------------------------------------------
-- Line numbers and display
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.showmode = true
vim.opt.cmdheight = 2
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.showmatch = false

-- Status line
vim.opt.laststatus = 3

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--------------------------------------------------------------------------------
-- Editor Behavior
--------------------------------------------------------------------------------
-- Mouse and clipboard
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split'

-- Tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

--------------------------------------------------------------------------------
-- File Handling
--------------------------------------------------------------------------------
-- History and undo
vim.opt.history = 1000
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.autoread = true

-- Backup handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

--------------------------------------------------------------------------------
-- Completion and Wild Menu
--------------------------------------------------------------------------------
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore:append {
  '*/node_modules/*',
  '*.pyc',
  '*.git/*',
  '*/vendor/*',
  '*.zip',
  '*.png',
  '*.jpg',
  '*.gif',
  '*.pdf',
  '*.DS_Store',
  '*/build/*',
  '*/dist/*',
}

--------------------------------------------------------------------------------
-- Fold Settings
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'vim.treesitter.foldexpr()'
vim.opt.foldenable = false
vim.opt.foldlevel = 99

--------------------------------------------------------------------------------
-- Spell Checking (enabled per filetype via autocmd below)
vim.opt.spell = false
vim.opt.spelllang = 'en_us'

-- Enable spell check only for text and markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'text', 'markdown', 'markdownvimwiki' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'gitrebase' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

--------------------------------------------------------------------------------
-- Basic Keymaps
--------------------------------------------------------------------------------
-- Clear search highlighting with <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
