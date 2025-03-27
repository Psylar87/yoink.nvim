return {
  -- "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  lazy = false,
  config = function()
    -- Load ts_context_commentstring if it exists
    local ok, ts_context = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')

    require('Comment').setup {
      -- Treesitter integration (only if available)
      pre_hook = ok and ts_context.create_pre_hook() or nil,

      -- Custom mappings configuration
      mappings = {
        basic = true, -- gcc and gc
        extra = true, -- gco, gcO, gcA
      },

      -- Sticky comment configuration
      sticky = true, -- Keeps cursor position when commenting

      -- Empty line and padding configuration
      comment_empty = false, -- Don't comment empty lines
      padding = true, -- Add a space after comment markers

      -- Ignore pattern and toggler/opleader configuration
      ignore = '^$', -- Ignore empty lines
      toggler = { line = 'gcc', block = 'gbc' },
      opleader = { line = 'gc', block = 'gb' },
    }
  end,
}
