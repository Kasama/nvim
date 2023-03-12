return {
  init = function(use)
    use { 'ellisonleao/glow.nvim', ft = 'markdown' }

    use({
      -- Markdown previewer
      "iamcco/markdown-preview.nvim",
      ft = 'markdown',
      build = function() vim.fn["mkdp#util#install"]() end,
    })
  end,
  lsp = function(setup_lsp)
    setup_lsp('marksman')
  end,
}
