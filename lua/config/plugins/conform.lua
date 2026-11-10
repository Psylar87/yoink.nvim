return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true }
        end,
        desc = '[F]ormat code',
      },
    },
    opts = {
      default_format_opts = { lsp_format = 'fallback' },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == 'markdown' or ft == 'text' or ft == 'gitcommit' then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = (ft == 'c' or ft == 'cpp') and 'never' or 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Add common web development formatters
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        -- Python formatting
        python = { 'ruff_format' }, -- Modern alternative to isort + black
        -- Shell script formatting
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        -- YAML/JSON formatting
        yaml = { 'yamlfmt' },
        -- Catch all files for common issues
        ['*'] = function(bufnr)
          -- Markdown trailing spaces can represent hard line breaks, even on manual format.
          if vim.bo[bufnr].filetype == 'markdown' then
            return {}
          end
          return { 'trim_whitespace', 'trim_newlines' }
        end,
      },
    },
  },
}
