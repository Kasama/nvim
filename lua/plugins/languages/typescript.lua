-- javascript and typescript
return {
  lsp = function(setup_lsp)
    setup_lsp('tsserver', {})
    setup_lsp('eslint', {})
  end
}
