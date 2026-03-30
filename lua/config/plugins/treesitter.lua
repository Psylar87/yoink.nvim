return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'fix/nightly',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        enabled = vim.fn.has 'nvim-0.12' == 0,
      },
    },
    opts = function()
      local nvim_012_or_newer = vim.fn.has 'nvim-0.12' == 1

      return {
        ensure_installed = {
          'bash',
          'c',
          'html',
          'javascript',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'tsx',
          'typescript',
          'vim',
          'yaml',
          'rust',
          'go',
        },
        sync_install = false,
        highlight = {
          enable = true,
          disable = nvim_012_or_newer and { 'markdown', 'markdown_inline' } or {},
          additional_vim_regex_highlighting = { 'ruby', 'markdown' },
        },
        indent = { enable = true, disable = { 'ruby', 'python' } },
        autotag = { enable = true },
        context_commentstring = { enable = not nvim_012_or_newer },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<C-s>',
            node_decremental = '<C-backspace>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end,
  },
}
