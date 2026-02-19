return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = function(bufnr)
        local disable_filetypes = {
          c = true,
          cpp = true,
          -- Consider adding other filetypes that don't have standardized formatting
          markdown = true,
          text = true,
          gitcommit = true,
        }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Add common web development formatters
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        -- Python formatting
        python = { 'ruff_format' }, -- Modern alternative to isort + black
        -- Shell script formatting
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        -- YAML/JSON formatting
        yaml = { 'yamlfmt' },
        -- Catch all files for common issues
        ['*'] = { 'trim_whitespace', 'trim_newlines' },
      },
    },
  },
}
