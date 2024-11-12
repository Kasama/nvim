GUTTER_SIGNS = { Info = '', Hint = '', Warn = '', Error = '' }
DIAGNOSTICS_SIGNS = {
  [vim.diagnostic.severity.ERROR] = GUTTER_SIGNS.Error,
  [vim.diagnostic.severity.WARN] = GUTTER_SIGNS.Warn,
  [vim.diagnostic.severity.INFO] = GUTTER_SIGNS.Info,
  [vim.diagnostic.severity.HINT] = GUTTER_SIGNS.Hint,
}
return {
  init = function(use, mason_install)
    use { -- nvim cmp
      'hrsh7th/nvim-cmp',
      event = "InsertEnter",
      dependencies = {
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        -- cmp needs a snippet engine
        'saadparwaiz1/cmp_luasnip',
        -- 'jcdickinson/codeium.nvim',
        { 'tris203/copilot-cmp', branch = '0.11_compat' },
        -- 'zbirenbaum/copilot.lua',
        'L3MON4D3/LuaSnip',
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local compare = require("cmp.config.compare")
        local lspkind = require("lspkind")
        -- local codeium = require('codeium')
        -- local copilot = require('copilot').setup({
        --   panel = { enabled = false },
        --   suggestion = { enabled = false },
        --   filetypes = { yaml = true },
        -- })
        require('copilot_cmp').setup()

        lspkind.init()

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = {
            { name = "nvim_lua" },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            -- { name = 'codeium' },
            -- { name = 'copilot' },
            { name = 'neorg' },
            { name = 'buffer',  keyword_length = 5 },
            { name = 'crates' },
          },
          formatting = {
            format = lspkind.cmp_format({
              mode = 'symbol',
              max_width = 50,
              menu = {
                nvim_lua = "[lua]",
                nvim_lsp = "[lsp]",
                path = "[path]",
                luasnip = "[snip]",
                buffer = "[buf]",
                -- codeium = "[llm]",
                -- copilot = "[llm]",
              },
              symbol_map = {
                -- Codeium = "",
                -- Copilot = "",
              }
            }),
          },
          mapping = cmp.mapping.preset.insert({
            -- ["<tab>"] = cmp.config.disable,
            -- ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-y>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }, { "i", "c" }),
            ["<C-n>"] = {
              i = cmp.mapping.select_next_item(),
            },
            ["<C-p>"] = {
              i = cmp.mapping.select_prev_item(),
            },
            ["<C-h>"] = {
              i = cmp.mapping.select_next_item(),
            },
            ["<C-Space>"] = cmp.mapping({
              i = cmp.mapping.complete(),
              c = function(_)
                if cmp.visible() then
                  if not cmp.confirm({ select = true }) then
                    return
                  end
                else
                  cmp.complete()
                end
              end,
            }),
          }),
          sorting = {
            comparators = {
              compare.exact,
              compare.score,
              compare.offset,
              compare.recently_used,
              compare.sort_text,
              compare.length,
              compare.order,
              compare.kind,
            },
          },
          window = {
            documentation = cmp.config.window.bordered()
          },
          experimental = {
            ghost_text = true
          }
        })

        -- codeium.setup({})

        -- local cmp_autopairs, ok = pcall(require, 'nvim-autopairs.completion.cmp')
        -- if ok and cmp_autopairs ~= nil then
        --   cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
        -- end
      end
    }

    -- Language specific configs
    local load_from = require('utils').load_from_factory('lua/kasama/plugins')
    LANGUAGE_LOADERS = load_from('languages')
    for _, language_loader in ipairs(LANGUAGE_LOADERS) do
      if type(language_loader.init) == "function" then
        if type(language_loader.only_if) == "function" then
          if language_loader.only_if() then
            language_loader.init(use, mason_install)
          end
        else
          language_loader.init(use, mason_install)
        end
      end
    end

    use { -- lspconfig
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        local masonlspconfig = require('mason-lspconfig')

        -- install all declared language servers automatically
        masonlspconfig.setup { automatic_installation = { exclude = { "ocamllsp" } } }

        local lsp_cmp = require('cmp_nvim_lsp')
        local lspconfig = require('lspconfig')

        -- `setup_lsp` is designed to be called by each language's setup to add the language
        -- server configuration.
        --
        -- Usage: `setup_lsp('rust_analyzer', {})`
        --
        -- @param lsp string or table
        --   It will call `lspconfig[lsp].setup` if `lsp` is a string and call `lsp.setup` if it's not
        --
        -- @param configs table or function
        --   if `configs` is a table, it will be injected with some defaults and passed to the setup
        --   function as decribed above. If it's a function, it will be called with an argument that
        --   is the function to inject the defaults and that function is expected to return a table
        --   with the configs
        local function setup_lsp(lsp, configs) -- {
          configs = configs or {}

          local setup_target = nil
          if type(lsp) == 'string' then
            setup_target = lspconfig[lsp]
          else
            setup_target = lsp
          end

          if (lsp_cmp) then
            local extra_client_capabilities = {
              textDocument = {
                completion = {
                  completionItem = {
                    snippetSupport = true,
                    resolveSupport = {
                      properties = { "documentation", "detail", "additionalTextEdits" },
                    },
                  },
                },
              },
            }

            local capabilities = lsp_cmp.default_capabilities(extra_client_capabilities)
            local default_configs = {
              capabilities = capabilities,
              flags = { debounce_text_changes = 150 },
            }

            local inject_config = function(config)
              config.on_attach_tmp = config.on_attach
              config.on_attach = nil

              local cascading_on_attach = {
                on_attach = function(client, bufnr)
                  if config.on_attach_tmp ~= nil then
                    config.on_attach_tmp(client, bufnr)
                  end
                  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
                end
              }

              config = vim.tbl_deep_extend('force', lspconfig.util.default_config, default_configs,
                config,
                cascading_on_attach)

              return config
            end

            if type(configs) == "function" then
              configs = configs(inject_config)
            else
              configs = inject_config(configs)
            end
          end
          setup_target.setup(configs)
        end -- }

        -- Setup diganostic signs {
        for type, icon in pairs(GUTTER_SIGNS) do
          local hl = 'DiagnosticSign' .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.diagnostic.config({
          severity_sort = true,
        })
        -- }

        vim.o.updatetime = 250
        local diagnostics_hold = vim.api.nvim_create_augroup('DiagnosticsCursorHold', { clear = true })
        local toggle_diagnostic_hover = function()
          if vim.g['DiagnosticHoverEnabled'] then
            vim.g['DiagnosticHoverEnabled'] = false
          else
            vim.g['DiagnosticHoverEnabled'] = true
          end
        end
        local open_diagnostic_float = function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            scope = 'cursor',
            source = 'if_many',
            prefix = function(diagnostic, _, _)
              local hl_map = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
              }
              return DIAGNOSTICS_SIGNS[diagnostic.severity] .. " ", hl_map[diagnostic.severity]
            end,
          })
        end

        require('utils').keybind({ 'n', '<leader>e', open_diagnostic_float })

        vim.api.nvim_create_user_command('DiagnosticHoverToggle', toggle_diagnostic_hover, {})
        vim.g['DiagnosticHoverEnabled'] = false
        vim.api.nvim_create_autocmd(
          { 'CursorHold', 'CursorHoldI' },
          {
            group = diagnostics_hold,
            pattern = '*',
            callback = function()
              local should_open_float = not vim.g["DiagnosticLinesEnabled"] and vim.g['DiagnosticHoverEnabled']

              if should_open_float then
                open_diagnostic_float()
              end
            end
          }
        )

        -- Language specific configs
        for _, language_loader in ipairs(LANGUAGE_LOADERS) do
          if type(language_loader.lsp) == "function" then
            if type(language_loader.only_if) == "function" then
              if language_loader.only_if() then
                language_loader.lsp(setup_lsp)
              end
            else
              language_loader.lsp(setup_lsp)
            end
          end
        end
      end
    }

    use { -- lsp diagnostic lines
      'Maan2003/lsp_lines.nvim',
      event = 'VeryLazy',
      config = function()
        require("lsp_lines").setup()

        local diag_line = function(state)
          if not state then
            vim.g['DiagnosticLinesEnabled'] = false
            vim.diagnostic.config({
              virtual_lines = state,
              virtual_text = {
                prefix = '',
                severity = vim.diagnostic.severity.ERROR,
                severity_sort = true,
                update_in_insert = true,
                format = function(diagnostic)
                  return string.format(DIAGNOSTICS_SIGNS[diagnostic.severity] .. " %s", diagnostic.message)
                end
              }
            })
          else
            vim.g['DiagnosticLinesEnabled'] = true
            vim.diagnostic.config({ virtual_lines = state, virtual_text = not state })
          end
        end

        diag_line(false)

        vim.api.nvim_create_user_command('DiagnosticLinesToggle', function()
          diag_line(not vim.g['DiagnosticLinesEnabled'])
        end, {})

        vim.api.nvim_create_user_command('DiagnosticLinesEnable', function() diag_line(true) end, {})
        vim.api.nvim_create_user_command('DiagnosticLinesDisable', function() diag_line(false) end, {})
      end,
    }

    use { -- lsp_signature
      'ray-x/lsp_signature.nvim',
      event = 'InsertEnter',
      config = function()
        require('lsp_signature').setup {
          bind = true,
          floating_window = true,
          hint_enable = false,
          handler_opts = {
            border = 'none'
          },
        }

        -- Underline current argument in lsp signature
        vim.cmd([[
        highlight LspSignatureActiveParameter gui=bold,underline cterm=bold,underline
        ]])
      end
    }

    use { -- trouble
      'folke/trouble.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
      config = function()
        require('trouble').setup {
          use_diagnostics_signs = true,
        }
      end,
    }

    use { -- null-ls
      'jose-elias-alvarez/null-ls.nvim',
      event = "VeryLazy",
      dependencies = {
        'williamboman/mason.nvim',
      },
      config = function()
        local null_ls = require('null-ls')
        local null_helpers = require('null-ls.helpers')
        local null_methods = require('null-ls.methods')

        local golint = null_helpers.make_builtin({
          name = "golint",
          method = null_methods.internal.DIAGNOSTICS_ON_SAVE,
          filetypes = { "go" },
          generator_opts = {
            command = "go",
            args = function()
              return {
                "run",
                "golang.org/x/lint/golint",
                "$FILENAME"
              }
            end,
            to_stdin = false,
            from_stderr = false,
            format = "line",
            on_output = null_helpers.diagnostics.from_patterns({
              {
                pattern = [[.+:(%d+):(%d+): (.+)]],
                groups = { "row", "col", "message" }
              }
            })
          },
          factory = null_helpers.generator_factory
        })

        null_ls.setup {
          sources = {
            null_ls.builtins.diagnostics.golangci_lint,
            golint,
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.formatting.xmllint,
          }
        }
      end,
    }

    use { -- highlight unused variables
      'Kasama/nvim-custom-diagnostic-highlight',
      lazy = true,
      config = function()
        require('nvim-custom-diagnostic-highlight').setup {}

        require('nvim-custom-diagnostic-highlight').setup {
          handler_name = "kasama/test_handler",
          diagnostic_handler_namespace = 'Kasama/test_handler',
          patterns_override = { 'global' },
          highlight_group = 'ErrorMsg',
          defer_until_n_lines_away = 3,
        }
      end
    }

    use { -- fidget LSP status
      'j-hui/fidget.nvim',
      branch = 'legacy',
      event = 'VeryLazy',
      config = function()
        require('fidget').setup {
          text = { spinner = 'arc' }
        }
      end,
    }

    use { --  indicator for code actions
      'gh-liu/nvim-lightbulb',
      event = 'VeryLazy',
      config = function()
        require('nvim-lightbulb').setup {
          autocmd = { enabled = true },
          sign = { enabled = false, },
          virtual_text = { enabled = false },
          status_text = {
            enabled = true,
            text = ' action'
          },
        }
      end,
    }

    use { -- lsp outline
      cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
      'simrat39/symbols-outline.nvim',
      config = function()
        require("symbols-outline").setup()
      end,
    }

    use { -- lsp inlay hints
      'lvimuser/lsp-inlayhints.nvim',
      config = function()
        require("lsp-inlayhints").setup({
          inlay_hints = {
            other_hints_prefix = "‣",
            highlight = "Conceal",
          }
        })
      end
    }

    use { -- lsp links
      'icholy/lsplinks.nvim',
      keys = "gx",
      config = function()
        require('lsplinks').setup()
      end
    }

    -- on lsp attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspAttach_default', { clear = true }),
      desc = 'LSP actions',
      callback = function(info)
        local bufmap = function(mode, lhs, rhs)
          local opts = { buffer = true }
          require('utils').keybind({ mode, lhs, rhs, opts })
        end
        local bufnr = info.buf

        -- enable codelens
        local codelens_capable = false
        for _, client in ipairs(vim.lsp.get_clients({ buffer = bufnr })) do
          if client.supports_method("textDocument/codeLens") then
            codelens_capable = true
            break
          end
        end
        -- if codelens_capable then
        if false then
          local codelens_autocmd = vim.api.nvim_create_augroup('CodeLensGroup', { clear = true })
          vim.api.nvim_create_autocmd(
            { 'BufEnter', 'CursorHold', 'InsertLeave' },
            {
              group = codelens_autocmd,
              buffer = info.buf,
              callback = vim.lsp.codelens.refresh
            })
          vim.cmd [[highlight LspCodeLens ctermfg=248 guifg=#999999]]

          bufmap('n', '<F2>', vim.lsp.codelens.run)
        end

        -- setup lsp signature helper
        require('lsp_signature').on_attach({
          bind = true,
          floating_window = true,
          hint_enable = false,
          handler_opts = {
            border = 'none'
          },
        }, info.buf)

        -- setup lsp inlay hints
        require('lsp-inlayhints').on_attach(vim.lsp.get_client_by_id(info.data.client_id), info.buf)

        -- auto format on save
        local formatting_capable = false
        for _, client in ipairs(vim.lsp.get_clients({ buffer = bufnr })) do
          if client.supports_method("textDocument/formatting") then
            formatting_capable = true
            break
          end
        end
        FORMAT_ON_SAVE_ENABLED = true
        local function format()
          if (FORMAT_ON_SAVE_ENABLED) then
            vim.lsp.buf.format()
          end
        end

        local format_on_save = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, { group = format_on_save, buffer = info.buf, callback = format })

        local function toggle_format_on_save()
          FORMAT_ON_SAVE_ENABLED = not FORMAT_ON_SAVE_ENABLED
          local msg = (FORMAT_ON_SAVE_ENABLED and "Enabled" or "Disabled") .. " format on save"
          vim.notify(msg, vim.log.levels.INFO, { title = "Format on Save", timeout = 10, hide_from_history = true })
        end

        bufmap('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end)
        bufmap('n', '<leader><leader>=', toggle_format_on_save)

        local telescope = require('telescope.builtin')

        bufmap('n', 'K', vim.lsp.buf.hover)
        bufmap('n', '<A-Space>', vim.lsp.buf.code_action)
        bufmap('n', '<A-Enter>', vim.lsp.buf.code_action)
        bufmap('n', '<leader>ref', telescope.lsp_references)
        bufmap('n', '<C-]>', telescope.lsp_definitions)
        bufmap('n', '<leader>impl', telescope.lsp_implementations)
        -- TODO: Eventually try to ignore mock implementations
        -- bufmap('n', '<leader>impl', function()
        --   telescope.lsp_implementations({
        --     finder = require('telescope.finders').new_table {
        --       results = locations,
        --       entry_maker = opts.entry_maker or make_entry.gen_from_lsp_symbols(opts),
        --     },
        --   })
        -- end)
        bufmap('n', '<leader>rn', vim.lsp.buf.rename)

        bufmap('n', 'g[', vim.diagnostic.goto_prev)
        bufmap('n', 'g]', vim.diagnostic.goto_next)
      end
    })
  end
}
