return {
  only_if = function()
    return not (vim.fn.executable('gcc') == 0)
  end,
  init = function(use, mason_install)
  end,
  lsp = function(setup_lsp)
    setup_lsp("clangd", {})
  end,
}
