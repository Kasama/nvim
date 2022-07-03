return {
  init = function(use)
    use { 'simrat39/rust-tools.nvim' }

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
        })
      }
    end)
  end,
}
