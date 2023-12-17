return {
  init = function(use, mason_install)
    mason_install('openscad-lsp')
  end,
  lsp = function(setup_lsp)
    setup_lsp("openscad_lsp", {})
  end,
}
