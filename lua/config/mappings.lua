local map = vim.keymap.set

-- Save and quit
map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save file' })
map('n', '<C-x>', '<cmd>x<cr>', { desc = 'Save and quit' })
map('n', '<C-q>', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Changed from <leader>e to <leader>d to avoid conflict with NvimTree
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- nvim-tree
map('n', '<C-f>', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree Toggle window' })
map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Nvimtree Focus window' })
map('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Nvimtree Find current file' })

local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Close buffer
map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)

-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Close commands (commented reference)
-- :BufferCloseAllButCurrent
-- :BufferCloseAllButPinned
-- :BufferCloseAllButCurrentOrPinned
-- :BufferCloseBuffersLeft
-- :BufferCloseBuffersRight

-- LSP mappings
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to [D]efinition' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to [R]eferences' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
map('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat code' })

-- Git mappings (for gitsigns)
map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = '[G]it [B]lame toggle' })
map('n', ']g', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next git hunk' })
map('n', '[g', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Previous git hunk' })
map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>', { desc = '[G]it [S]tage hunk' })
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', { desc = '[G]it [R]eset hunk' })
map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', { desc = '[G]it [P]review hunk' })

-- Obsidian mappings
map('n', '<leader>on', '<cmd>ObsidianNew<CR>', { desc = '[O]bsidian [N]ew note' })
map('n', '<leader>oo', '<cmd>ObsidianOpen<CR>', { desc = '[O]bsidian [O]pen' })
map('n', '<leader>os', '<cmd>ObsidianSearch<CR>', { desc = '[O]bsidian [S]earch' })
map('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = '[O]bsidian [B]acklinks' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
