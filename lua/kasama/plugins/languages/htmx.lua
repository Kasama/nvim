return {
  only_if = function()
    return (vim.fn.executable('cargo') == 1)
  end,
  init = function(use)
  end,
  lsp = function(setup_lsp)
    setup_lsp('htmx', {
      filetypes = { "html", "htmldjango", "templ" }
    })
  end,
}
