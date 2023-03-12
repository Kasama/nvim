return {
  init = function(use)
    use { 'andys8/vim-elm-syntax', ft = 'elm' }

    local elm_augroup = vim.api.nvim_create_augroup('ElmConfig', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      group = elm_augroup,
      pattern = '*.elm',
      command = "setlocal shiftwidth=4 tabstop=4"
    })
  end,
  lsp = function(setup_lsp)
    setup_lsp('elmls', {})
  end,
}
