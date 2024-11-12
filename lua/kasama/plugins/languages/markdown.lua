return {
  init = function(use)
    use { 'ellisonleao/glow.nvim', ft = { 'markdown' } }

    use { 'MeanderingProgrammer/markdown.nvim', opts = {
      file_types = { "markdown", "Avante" },
    }, ft = { 'markdown', 'Avante' } }

    -- Another markdown option, try later
    -- use {
    --   "OXY2DEV/markview.nvim",
    --   lazy = false, -- Recommended
    --   -- ft = "markdown" -- If you decide to lazy-load anyway

    --   dependencies = {
    --     -- You will not need this if you installed the
    --     -- parsers manually
    --     -- Or if the parsers are in your $RUNTIMEPATH
    --     "nvim-treesitter/nvim-treesitter",

    --     "nvim-tree/nvim-web-devicons"
    --   }
    -- }

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
