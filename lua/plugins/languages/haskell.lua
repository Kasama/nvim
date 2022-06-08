return {
  init = function(use)
  end,
  lsp = function(setup_lsp)
    setup_lsp('hie', {
      init_options = {
        languageServerHaskell = {
          hlintOn = true;
        }
      }
    })
  end,
}
