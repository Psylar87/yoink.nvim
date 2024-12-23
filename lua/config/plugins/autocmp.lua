--------------------------------------------------------------------------------
-- Autocompletion: nvim-cmp + LuaSnip
--------------------------------------------------------------------------------
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        -- Build step for regex snippet support (may fail on Windows without `make`)
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Extra completion sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Optionally add cmp-buffer if you like buffer-based completions
      'hrsh7th/cmp-buffer',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- Configure LuaSnip
      luasnip.config.setup {}

      -- Set up nvim-cmp
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Auto-confirm the currently selected completion item with <C-y>
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger completion
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Snippet jumping
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),

          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          -- If you added 'hrsh7th/cmp-buffer':
          { name = 'buffer' },
          { name = 'render-markdown' },
        },
      }
    end,
  },
}
