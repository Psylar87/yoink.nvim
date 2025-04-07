--------------------------------------------------------------------------------
-- Mapping Configuration
--------------------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--------------------------------------------------------------------------------
-- Mini.nvim Mappings
--------------------------------------------------------------------------------
local function setup_mini_mappings()
  map('n', '<leader>bd', function()
    require('mini.bufremove').delete()
  end, { desc = 'Delete buffer' })

  map('n', 'gS', function()
    require('mini.splitjoin').toggle()
  end, { desc = 'Toggle split/join' })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyLoad',
  callback = function(event)
    if event.data == 'mini.nvim' then
      setup_mini_mappings()
    end
  end,
})

--------------------------------------------------------------------------------
-- General Mappings
--------------------------------------------------------------------------------
-- Save and quit
map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
map('n', '<C-x>', '<cmd>x<cr>', { desc = 'Save and quit' })
map('n', '<C-q>', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Window Navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window Resizing
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Better indenting
map('v', '<', '<gv', { desc = 'Indent left and keep selection' })
map('v', '>', '>gv', { desc = 'Indent right and keep selection' })

-- Move selected text up/down
map('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move selected text down' })
map('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move selected text up' })

--------------------------------------------------------------------------------
-- Terminal Mappings
--------------------------------------------------------------------------------
map('t', '<C-h>', '<C-\\><C-N><C-w>h', { desc = 'Terminal: move left' })
map('t', '<C-j>', '<C-\\><C-N><C-w>j', { desc = 'Terminal: move down' })
map('t', '<C-k>', '<C-\\><C-N><C-w>k', { desc = 'Terminal: move up' })
map('t', '<C-l>', '<C-\\><C-N><C-w>l', { desc = 'Terminal: move right' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal: exit insert mode' })

--------------------------------------------------------------------------------
-- Diagnostic Mappings
--------------------------------------------------------------------------------
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '[d', vim.diagnostic.prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.next, { desc = 'Next diagnostic' })

--------------------------------------------------------------------------------
-- Nvim-tree Mappings
--------------------------------------------------------------------------------
map('n', '<C-f>', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree Toggle window' })
map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree Focus window' })
map('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Nvimtree Find current file' })

--------------------------------------------------------------------------------
-- Buffer Management (Barbar)
--------------------------------------------------------------------------------
-- Navigation
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Buffer selection
for i = 1, 9 do
  map('n', string.format('<A-%s>', i), string.format('<Cmd>BufferGoto %s<CR>', i), opts)
end
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Buffer operations
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- Buffer sorting
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

--------------------------------------------------------------------------------
-- LSP Mappings
--------------------------------------------------------------------------------
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to [D]efinition' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to [R]eferences' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to [D]eclaration' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to [I]mplementation' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
map('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat code' })

--------------------------------------------------------------------------------
-- Git Mappings (Gitsigns)
--------------------------------------------------------------------------------
map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = '[G]it [B]lame toggle' })
map('n', ']g', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next git hunk' })
map('n', '[g', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Previous git hunk' })
map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { desc = '[G]it [S]tage hunk' })
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { desc = '[G]it [R]eset hunk' })
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[G]it [P]review hunk' })

--------------------------------------------------------------------------------
-- Quick Fix List Navigation
--------------------------------------------------------------------------------
map('n', '[q', ':cprevious<CR>', { desc = 'Previous quickfix item' })
map('n', ']q', ':cnext<CR>', { desc = 'Next quickfix item' })
map('n', '<leader>qf', ':copen<CR>', { desc = 'Open quickfix list' })
map('n', '<leader>qc', ':cclose<CR>', { desc = 'Close quickfix list' })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
