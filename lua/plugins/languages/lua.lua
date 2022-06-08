return {
  lsp = function(setup_lsp)
    setup_lsp('sumneko_lua', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
          },
          telemetry = {
            enable = false
          },
        }
      },
      single_file_support = true,
      on_attach = function(_, _)
      end,
    })
  end,
}
