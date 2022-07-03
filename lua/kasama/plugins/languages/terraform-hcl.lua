return {
  init = function(use)
    use { 'hashivim/vim-terraform' }
  end,
  lsp = function(setup_lsp)
    setup_lsp('terraformls')
  end,
}
