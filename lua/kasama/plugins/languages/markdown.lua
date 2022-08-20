return {
  init = function(use)
    use { 'ellisonleao/glow.nvim' }

    use({ -- Markdown previewer
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
  end,
  lsp = function(setup_lsp)
    setup_lsp('marksman')
  end,
}
