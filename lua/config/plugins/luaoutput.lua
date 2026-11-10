return {
  {
    'MillerApps/luaoutput',
    cmd = 'LuaOutput',
    keys = {
      { '<leader>xl', '<cmd>LuaOutput<cr>', desc = 'Run current buffer as Lua' },
    },
    config = function()
      -- The plugin hard-codes Alt-l, which belongs to mini.move in this configuration.
      local previous = vim.fn.maparg('<A-l>', 'n', false, true)
      require('luaoutput').setup()
      vim.keymap.del('n', '<A-l>')
      if previous.lhs then
        vim.fn.mapset('n', false, previous)
      end
    end,
  },
}
