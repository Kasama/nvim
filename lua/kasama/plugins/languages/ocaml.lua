return {
  init = function(use, mason_install)
    mason_install('ocamlformat')
  end,
  lsp = function(setup_lsp)
    setup_lsp("ocamllsp", {})
  end,
}
