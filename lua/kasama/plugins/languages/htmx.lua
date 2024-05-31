return {
  init = function(use)
  end,
  lsp = function(setup_lsp)
    setup_lsp('htmx', {
      filetypes = { "html", "templ" }
    })
  end,
}
