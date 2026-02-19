return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      presets = {
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
      },
      lsp = {
        hover = {
          enabled = true,
          silent = false,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
          },
        },
      },
      messages = {
        enabled = true,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = 'virtualtext',
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = 'search_count',
          },
          opts = { skip = true },
        },
        {
          view = 'split',
          filter = { event = 'msg_show', min_height = 20 },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    keys = {
      {
        '<S-Enter>',
        function()
          require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline',
      },
      {
        '<leader>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Noice Last Message',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Noice History',
      },
      {
        '<M-f>',
        function()
          if not require('noice.lsp').scroll(4) then
            return '<M-f>'
          end
        end,
        mode = { 'i', 'n', 's' },
        expr = true,
      },
      {
        '<M-b>',
        function()
          if not require('noice.lsp').scroll(-4) then
            return '<M-b>'
          end
        end,
        mode = { 'i', 'n', 's' },
        expr = true,
      },
    },
  },
}
