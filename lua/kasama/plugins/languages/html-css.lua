return {
  init = function(use)
    use {
      'NvChad/nvim-colorizer.lua',
      event = 'VeryLazy',
      config = function()
        require('colorizer').setup()
      end
    }
  end,
  lsp = function(setup_lsp)
    if (vim.fn.executable('npm') == 1) then
      setup_lsp('html', {})
      setup_lsp('cssls', {})
      setup_lsp('stylelint_lsp', {})
      setup_lsp('cssmodules_ls', {})
      setup_lsp('emmet_ls', {
        filetypes = { 'html', 'htmldjango', 'templ', 'heex' },
      })
      setup_lsp('tailwindcss', {
        root_dir = require('lspconfig.util').root_pattern('go.mod', 'tailwind.config.js', 'tailwind.config.cjs',
          'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs',
          'postcss.config.ts', 'package.json', 'node_modules', '.git', 'Cargo.toml'),
      })
      -- setup_lsp('tailwindcss', {})
    end
  end
}
