-- javascript and typescript
return {
  only_if = function()
    return (vim.fn.executable('npm') == 1)
  end,
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
    setup_lsp('ts_ls', {
      root_dir = require('lspconfig.util').root_pattern('package.json'),
      single_file_support = false,
    })
    if (vim.fn.executable('deno') == 1) then
      setup_lsp('denols', {
        root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc'),
      })
    end
    setup_lsp('eslint', {})
    setup_lsp('svelte', {
      root_dir = require('lspconfig.util').root_pattern('svelte.config.js'),
    })
  end
}
