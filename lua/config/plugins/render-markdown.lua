return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    opts = {
      -- Enable rendering in more modes (default is only 'n', 'c', 't')
      render_modes = { 'n', 'i', 'v', 'c', 't' },
      -- Better heading configuration
      heading = {
        width = 'full',
        left_pad = 1,
        right_pad = 1,
        -- Add borders above/below headings
        border = true,
      },
      -- Enhance code blocks
      code = {
        -- Show language name and icon
        style = 'full',
        -- Add padding around code
        left_pad = 1,
        right_pad = 1,
        -- Use block width instead of full width
        width = 'block',
      },
      -- Improve list appearance
      bullet = {
        -- Add padding around bullets
        left_pad = 1,
        right_pad = 1,
      },
      -- Better checkbox rendering
      checkbox = {
        -- Add padding after checkboxes
        right_pad = 1,
      },
      -- Enhanced table rendering
      pipe_table = {
        -- Use padded style for better readability
        cell = 'padded',
        -- Add padding between cell contents and borders
        padding = 1,
      },
      -- Anti-conceal settings
      anti_conceal = {
        -- Hide virtual text on cursor line
        enabled = true,
        -- Show some elements even with anti_conceal
        ignore = {
          code_background = true,
          sign = true,
        },
      },
      -- Enable LaTeX rendering
      latex = {
        enabled = true,
        -- Render above the block
        position = 'above',
      },

      -- Enable completions
      completions = {
        -- Enable LSP completions
        lsp = { enabled = true },
      },
    },
    -- Load for markdown and markdown-like files
    ft = { 'markdown', 'vimwiki' },
  },
}
