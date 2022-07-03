-- javascript and typescript
return {
  init = function(use)
    use {
      'vuki656/package-info.nvim',
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require('package-info').setup()
      end
    }
  end,
  lsp = function(setup_lsp)
    setup_lsp('tsserver', {})
    setup_lsp('eslint', {})
  end
}
