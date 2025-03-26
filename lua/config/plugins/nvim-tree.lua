return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = {
            min = 32,
            max = 36,
            padding = 1,
          },
          relativenumber = false,
        },
        renderer = {
          group_empty = true,
          highlight_modified = 'name',
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        modified = {
          enable = true,
          show_on_dirs = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = true,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
        },
      }
    end,
  },
}
