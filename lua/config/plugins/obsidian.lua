local obsidian_config = {
  'obsidian-nvim/obsidian.nvim',
  enabled = require('config.platform').is_mac,
  version = '*',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    local obsidian_path = vim.fs.joinpath(vim.env.HOME, 'Library/Mobile Documents/iCloud~md~obsidian/Documents/Dev/')
    local fallback_path = vim.fs.joinpath(vim.fn.stdpath 'data', 'obsidian', 'Dev')

    if vim.fn.isdirectory(obsidian_path) == 0 then
      vim.notify('Obsidian iCloud path unavailable, using local fallback vault', vim.log.levels.WARN)
      if not vim.uv.fs_stat(fallback_path) then
        pcall(vim.fn.mkdir, fallback_path, 'p')
      end
      obsidian_path = fallback_path
    end

    return {
      ui = { enable = false },
      workspaces = {
        {
          name = 'Dev',
          path = obsidian_path,
        },
      },
      completion = {
        min_chars = 2,
      },
      picker = {
        name = 'telescope.nvim',
      },
      legacy_commands = false,
      frontmatter = {
        func = function(note)
          local out = {
            id = note.id,
            created = os.date '!%Y-%m-%d %H:%M:%S',
            title = note.title or note.id,
            aliases = note.aliases,
            tags = note.tags,
          }
          for k, v in pairs(note.metadata or {}) do
            out[k] = v
          end
          return out
        end,
      },
    }
  end,
  keys = {
    { '<leader>of', '<cmd>Obsidian search<cr>', desc = 'Search files' },
    { '<leader>os', '<cmd>Obsidian quick_switch<cr>', desc = 'Quick switch' },
    { '<leader>on', '<cmd>Obsidian new<cr>', desc = 'New note' },
    { '<leader>ol', '<cmd>Obsidian follow_link<cr>', desc = 'Follow link' },
    { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Show backlinks' },
    { '<leader>ot', '<cmd>Obsidian tags<cr>', desc = 'Browse tags' },
  },
}

return obsidian_config
