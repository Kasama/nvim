return {
  only_if = function()
    return (vim.fn.executable('cargo') == 1)
  end,
  init = function(use, mason_install)
    mason_install('openscad-lsp')
  end,
  lsp = function(setup_lsp)
    setup_lsp("openscad_lsp", {})
  end,
}
