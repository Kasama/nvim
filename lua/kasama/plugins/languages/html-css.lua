return {
  init = function(use)
    use { -- apply color to css color codes
      '/RRethy/vim-hexokinase',
      run = 'make hexokinase',
      config = function()
      end,
    }
  end,
  lsp = function(setup_lsp)
    setup_lsp('html', {})
    setup_lsp('cssls', {})
    setup_lsp('cssmodules_ls', {})
    setup_lsp('stylelint_lsp', {})
    setup_lsp('emmet_ls', {})
    -- setup_lsp('tailwindcss', {})
  end
}
