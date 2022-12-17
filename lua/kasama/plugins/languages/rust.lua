return {
  only_if = function()
    return not vim.fn.executable('rustc') == 0
  end,
  init = function(use, mason_install)
    local rust_augroup = vim.api.nvim_create_augroup('RustConfig', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      group = rust_augroup,
      pattern = 'rust',
      command = "setlocal shiftwidth=4"
    })
    -- debugger for rust
    mason_install('codelldb')

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
    local mason = require('mason-registry')
    local dap_cfg = {}

    local ok, corelldb = pcall(mason.get_package, 'codelldb')
    if ok then
      local codelldb_install_path = corelldb:get_install_path() .. '/extension'
      local codelldb_path = codelldb_install_path .. '/adapter/codelldb'
      local liblldb_path = codelldb_install_path .. '/lldb/lib/liblldb.so'

      dap_cfg = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
      }
    end

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
              checkOnSave = {
                -- default
                -- command = "check"
                command = "clippy",
              },
              procMacro = {
                enable = true
              }
            }
          }
        }),
        dap = dap_cfg,
      }
    end)
  end,
}
