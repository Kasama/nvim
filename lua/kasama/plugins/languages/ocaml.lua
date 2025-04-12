return {
  only_if = function()
    return (vim.fn.executable('opam') == 1)
  end,
  init = function(use, mason_install)
    -- mason_install('ocamlformat')
  end,
  lsp = function(setup_lsp)
    setup_lsp("ocamllsp", {})
  end,
}
