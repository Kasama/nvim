return {
  only_if = function()
    return (vim.fn.executable('nix') == 1)
  end,
  init = function(use, mason_install)
  end,
  lsp = function(setup_lsp)
    setup_lsp("nil_ls", {})
  end,
}
