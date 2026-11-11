--------------------------------------------------------------------------------
-- LSP Configuration & Plugins
--------------------------------------------------------------------------------
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        'blink.cmp',
        'snacks.nvim',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      ----------------------------------------------------------------------------
      --  Setup LSP-on-attach Keymappings
      ----------------------------------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Keymaps
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = event.data and vim.lsp.get_client_by_id(event.data.client_id) or nil
          if not client then
            return
          end

          ----------------------------------------------------------------------------
          -- Go import organize on save
          ----------------------------------------------------------------------------
          if client.name == 'gopls' then
            local go_imports_group = vim.api.nvim_create_augroup('user-lsp-go-imports-' .. event.buf, { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = go_imports_group,
              buffer = event.buf,
              callback = function()
                require('config.go').organize_imports(client, event.buf)
              end,
            })
          end

          ----------------------------------------------------------------------------
          -- Document highlight
          ----------------------------------------------------------------------------
          if client:supports_method 'textDocument/documentHighlight' then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      ----------------------------------------------------------------------------
      -- Extend LSP Capabilities
      ----------------------------------------------------------------------------
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      ----------------------------------------------------------------------------
      -- Servers Configuration
      ----------------------------------------------------------------------------
      local servers = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
            },
          },
        },

        bashls = {},

        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
            },
          },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'basic',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      }

      ----------------------------------------------------------------------------
      -- Mason Setup
      ----------------------------------------------------------------------------
      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'bash-language-server',
          'lua-language-server',
          'rust-analyzer',
          'gopls',
          'pyright',
          'stylua',
          'debugpy',
          'delve',
          'codelldb',
          'prettierd',
          'shfmt',
          'yamlfmt',
          'ruff',
          'goimports',
          'gofumpt',
          'golangci-lint',
        },
        auto_update = false,
        run_on_start = false,
        -- Installing tools should not load the debugger and its UI at startup.
        integrations = { ['mason-nvim-dap'] = false, ['mason-null-ls'] = false },
      }

      ----------------------------------------------------------------------------
      -- Lua LSP
      ----------------------------------------------------------------------------
      servers.lua_ls = {
        on_init = function(client)
          local folder = client.workspace_folders and client.workspace_folders[1]
          local path = folder and folder.name
          if type(path) == 'string' and path ~= vim.fn.stdpath 'config' then
            local has_luarc = vim.fn.filereadable(path .. '/.luarc.json') == 1 or vim.fn.filereadable(path .. '/.luarc.jsonc') == 1
            if has_luarc then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
            runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
            diagnostics = { globals = { 'vim', 'Snacks' } },
          })
        end,
        settings = { Lua = {} },
      }

      -- Mason v2 no longer supports setup handlers. Configure before enabling servers.
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = false,
      }
      -- Also supports servers installed outside Mason.
      vim.lsp.enable(vim.tbl_keys(servers))

      ----------------------------------------------------------------------------
      -- Optional: Go test shortcut
      ----------------------------------------------------------------------------
      vim.keymap.set('n', '<leader>gt', function()
        vim.cmd 'terminal go test ./...'
      end, { desc = 'Go Test All' })
    end,
  },
}
