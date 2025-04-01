return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = false,
  priority = 50,
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
        crated = os.date '!%Y-%m-%d %H:%M:%S',
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
