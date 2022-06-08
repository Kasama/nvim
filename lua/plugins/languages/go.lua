return {
  init = function(use)
  end,
  lsp = function(setup_lsp)
    setup_lsp('gopls', {
      staticcheck = true,
      codelenses = {
        generate = true
      }
    })
  end,
}
