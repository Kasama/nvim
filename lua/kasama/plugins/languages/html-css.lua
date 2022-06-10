return {
  init = function(use)
    use 'ap/vim-css-color' -- apply color to css color codes
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
