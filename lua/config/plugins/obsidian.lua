local obsidian_config = {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
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
  keys = {
    { '<leader>of', '<cmd>ObsidianSearch<cr>', desc = 'Search files' },
    { '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'New note' },
    { '<leader>ol', '<cmd>ObsidianFollowLink<cr>', desc = 'Follow link' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Show backlinks' },
    { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Browse tags' },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)
  end,
}
return obsidian_config
