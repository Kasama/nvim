return {
  only_if = function()
    return (vim.fn.executable('npm') == 1)
  end,
  lsp = function(setup_lsp)
    setup_lsp('dockerls', {})
  end,
}
