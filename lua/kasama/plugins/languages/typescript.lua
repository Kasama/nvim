-- javascript and typescript
return {
  init = function(use)
    use {
      'vuki656/package-info.nvim',
      ft = { 'javascript', 'typescript', 'json', 'jsx' },
      dependencies = "MunifTanjim/nui.nvim",
      config = function()
        require('package-info').setup()
      end
    }
  end,
  lsp = function(setup_lsp)
    setup_lsp('tsserver', {
      root_dir = require('lspconfig.util').root_pattern('package.json'),
      single_file_support = false,
    })
    setup_lsp('denols', {
      root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc'),
    })
    setup_lsp('eslint', {})
  end
}
