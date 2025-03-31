-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Line numbers and relative numbers
vim.opt.number = true
vim.opt.relativenumber = false -- Helps with motion commands

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Preview substitutions live, as you type
vim.opt.inccommand = 'split'

-- Tab and indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Visual enhancements
vim.opt.termguicolors = true
vim.opt.showmatch = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.showmode = true
vim.opt.cmdheight = 2

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10

-- Performance and history
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.history = 1000

-- File handling
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.autoread = true

-- Status line
vim.opt.laststatus = 3

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Clear search highlighting with <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
