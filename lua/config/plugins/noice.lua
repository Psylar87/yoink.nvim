return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
      presets = {
        -- disabled for now as it's not working properly
        -- with blink.cmp, not sure if it be fixed, or if its a skill issue
        -- on my part
        -- possible relavent links:
        -- https://github.com/Saghen/blink.cmp/pull/532
        -- https://github.com/Saghen/blink.cmp/pull/323
        command_palette = false,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
}
