return {
  only_if = function()
    return not (vim.fn.executable('terraform') == 0)
  end,
  init = function(use)
    use { 'hashivim/vim-terraform' }
  end,
  lsp = function(setup_lsp)
    setup_lsp('terraformls')
  end,
}
