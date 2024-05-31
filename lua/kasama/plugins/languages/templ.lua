return {
  init = function(use)
    vim.filetype.add({ extension = { templ = "templ" } })
  end,
  lsp = function(setup_lsp)
    setup_lsp('templ')
  end,
}
