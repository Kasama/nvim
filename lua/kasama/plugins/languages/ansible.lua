return {
  only_if = function()
    return (vim.fn.executable('python') == 1) and (vim.fn.executable('npm') == 1)
  end,
  init = function(use)
  end,
  lsp = function(setup_lsp)
    setup_lsp('ansiblels', {})
  end
}
