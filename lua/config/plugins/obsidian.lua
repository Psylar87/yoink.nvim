local obsidian_config = {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  opts = {
    -- disable ui in favor of render-markdown.nvim
    ui = { enable = false },
    workspaces = {
      {
        name = 'Dev',
        path = vim.fn.expand '$HOME' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/Dev/',
      },
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },
    picker = {
      name = 'telescope.nvim',
    },
    note_frontmatter_func = function(note)
      local out = {
        created = os.date '!%Y-%m-%d %H:%M:%S',
        title = note.id,
        aliases = note.aliases,
        tags = note.tags,
      }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,
  },
}
-- Set up keymaps
vim.keymap.set('n', '<leader>of', ':ObsidianSearch<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<CR>', { desc = 'Quick switch' })
vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>', { desc = 'New note' })
vim.keymap.set('n', '<leader>ol', ':ObsidianFollowLink<CR>', { desc = 'Follow link' })
vim.keymap.set('n', '<leader>ob', ':ObsidianBacklinks<CR>', { desc = 'Show backlinks' })
vim.keymap.set('n', '<leader>ot', ':ObsidianTags<CR>', { desc = 'Browse tags' })

return obsidian_config
