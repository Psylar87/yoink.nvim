return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dim = { enabled = false },
    terminal = {
      enabled = true,
      win = {
        height = 0.3,
        float = true,
      },
    },
    lazygit = {
      enabled = true,
      win = {
        width = 0.9,
        height = 0.9,
        float = true,
      },
      config = {
        gui = {
          theme = {
            activeBorderColor = { '#74c7ec' },
          },
        },
      },
    },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    bigfile = { enabled = false },
    dashboard = {
      enabled = true,
      example = 'compact_files',
    },
    indent = { enabled = true },
    input = { enabled = true },
    --    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = {
      enabled = true,
      notify_jump = true,
      notify_end = true,
    },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = false,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
  },
  keys = {
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current File History',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<a-t>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>dd',
      function()
        Snacks.dim()
      end,
      desc = 'Dim On',
    },
    {
      '<leader>do',
      function()
        Snacks.dim.disable()
      end,
      desc = 'Dim Off',
    },
  },
}
