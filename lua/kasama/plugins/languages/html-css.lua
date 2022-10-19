return {
  init = function(use)
    use {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end
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
