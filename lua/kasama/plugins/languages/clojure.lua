return {
  only_if = function()
    return (vim.fn.executable('clojure') == 1) and (vim.fn.executable('unzip') == 1)
  end,
  lsp = function(setup_lsp)
    setup_lsp('clojure_lsp', {})
  end,
}
