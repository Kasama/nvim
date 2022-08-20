return {
  init = function(use)
    use {
      'simrat39/rust-tools.nvim',
      config = function()
        local keybind = require('utils').keybind

        local rust_group = vim.api.nvim_create_augroup("RustConfigs", { clear = true })
        vim.api.nvim_create_autocmd(
          "FileType",
          {
            group = rust_group,
            pattern = {
              "rust",
            },
            callback = function()
              keybind({ 'n', '<F5>', function()
                local dap = require('dap')
                local rust = require('rust-tools')

                local status = dap.status()
                if status == "" then
                  rust.debuggables.debuggables()
                else
                  dap.continue()
                end

              end, { buffer = true } })
            end,
          }
        )
      end,
    }

    use {
      'Saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      tag = 'v0.2.1',
      requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
      config = function()
        local null_ls = require('null-ls')
        require('crates').setup({
          null_ls = {
            enabled = true,
            name = "crates.nvim"
          }
        })
      end,
    }
  end,
  lsp = function(setup_lsp)
    local rust_tools = require('rust-tools')

    local codelldb_extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.7.4/'
    local codelldb_path = codelldb_extension_path .. 'adapter/codelldb'
    local liblldb_path = codelldb_extension_path .. 'lldb/lib/liblldb.so'

    setup_lsp(rust_tools, function(inject_config)
      return {
        tools = {
          inlay_hints = {
            other_hints_prefix = "‣",
            highlight = "Conceal",
          },
          hover_actions = {
            border = false
          }
        },
        server = inject_config({
          settings = {
            ["rust-analyzer"] = {
              assist = {
                importGranularity = "module",
                importPrefix = "self",
              },
              cargo = {
                loadOutDirsFromCheck = true
              },
              procMacro = {
                enable = true
              }
            }
          }
        }),
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        }
      }
    end)
  end,
}
