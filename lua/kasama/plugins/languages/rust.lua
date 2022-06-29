return {
  init = function(use)
    use {
      'simrat39/rust-tools.nvim',
      config = function()
        local rust_tools = require('rust-tools')
        -- rust_tools.setup({})
      end
    }
  end,
  lsp = function(setup_lsp)
    local rust_tools = require('rust-tools')
    setup_lsp(rust_tools, function(inject_config)
      return {
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
