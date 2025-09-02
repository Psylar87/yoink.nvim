local obsidian_config = {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    -- Ensure the path exists before configuring
    local obsidian_path = vim.fn.expand '$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Dev/'

    -- Create directory if it doesn't exist
    if vim.fn.isdirectory(obsidian_path) == 0 then
      vim.fn.mkdir(obsidian_path, 'p')
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
        nvim_cmp = false,
        min_chars = 2,
      },
      picker = {
        name = 'telescope.nvim',
      },
      legacy_commands = false,
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
    }
  end,
  keys = {
    { '<leader>of', '<cmd>ObsidianSearch<cr>',      desc = 'Search files' },
    { '<leader>os', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
    { '<leader>on', '<cmd>ObsidianNew<cr>',         desc = 'New note' },
    { '<leader>ol', '<cmd>ObsidianFollowLink<cr>',  desc = 'Follow link' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>',   desc = 'Show backlinks' },
    { '<leader>ot', '<cmd>ObsidianTags<cr>',        desc = 'Browse tags' },
  },
  config = function(_, opts)
    -- Ensure opts is called if it's a function
    local options = type(opts) == 'function' and opts() or opts
    require('obsidian').setup(options)
  end,
}

return obsidian_config
