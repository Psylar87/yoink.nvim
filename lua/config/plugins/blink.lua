return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      -- the deafaults
      -- are defined here:
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- ['<C-e>'] = { 'hide' },
      -- ['<C-y>'] = { 'select_and_accept' },
      --
      -- ['<C-p>'] = { 'select_prev', 'fallback' },
      -- ['<C-n>'] = { 'select_next', 'fallback' },
      --
      -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      --
      -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
      -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      keymap = { preset = 'default' },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = true },
        menu = {
          draw = {
            columns = {
              { 'label',     'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
      },

      -- Experimental signature help support
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },

      fuzzy = {
        implementation = 'prefer_rust_with_warning',
        sorts = {
          'exact', -- prioritize exact matches
          'score',
          'sort_text',
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- TODO: add providers options and set priority
        providers = {
          lsp = {
            name = 'LSP',
            fallbacks = { 'buffer' }, -- fallback to buffer when LSP returns no results
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text
              end, items)
            end,
          },
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
