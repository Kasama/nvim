return {
  only_if = function()
    return (vim.fn.executable('gcc') == 1) and (vim.fn.executable('unzip') == 1)
  end,
  init = function(use, mason_install)
  end,
  lsp = function(setup_lsp)
    setup_lsp("clangd", {})
  end,
}
