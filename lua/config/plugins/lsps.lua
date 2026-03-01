--------------------------------------------------------------------------------
-- LSP Configuration & Plugins
--------------------------------------------------------------------------------
return {
  { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
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

          local client = event.client

          ----------------------------------------------------------------------------
          -- Format + Go import organize on save
          ----------------------------------------------------------------------------
          if client and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                -- Go: organize imports first
                if client.name == 'gopls' then
                  local params = vim.lsp.util.make_range_params()
                  params.context = { only = { 'source.organizeImports' } }

                  local result = vim.lsp.buf_request_sync(event.buf, 'textDocument/codeAction', params, 1000)
                  for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                      if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, 'utf-16')
                      end
                    end
                  end
                end

                vim.lsp.buf.format { buffer = event.buf }
              end,
            })
          end

          ----------------------------------------------------------------------------
          -- Document highlight
          ----------------------------------------------------------------------------
          if client and client.server_capabilities.documentHighlightProvider then
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
              checkOnSave = { command = 'clippy' },
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
          'prettierd',
          'shfmt',
          'yamlfmt',
          'ruff',
          'goimports',
          'gofumpt',
          'golangci-lint',
        },
        auto_update = false,
        run_on_start = true,
      }

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
          end,
        },
      }

      ----------------------------------------------------------------------------
      -- Lua LSP
      ----------------------------------------------------------------------------
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
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
      })
      vim.lsp.enable 'lua_ls'

      ----------------------------------------------------------------------------
      -- Optional: Go test shortcut
      ----------------------------------------------------------------------------
      vim.keymap.set('n', '<leader>gt', function()
        vim.cmd 'terminal go test ./...'
      end, { desc = 'Go Test All' })
    end,
  },
}
