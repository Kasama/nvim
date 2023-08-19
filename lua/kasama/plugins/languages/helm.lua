return {
  init = function(use)
    use 'towolf/vim-helm'
  end,
  lsp = function(setup_lsp)
    setup_lsp('helm_ls', {
      settings = {
        filetypes = { 'helm' },
        root_dir = require('lspconfig.util').root_pattern('Chart.yaml'),
      }
    })
  end
}
