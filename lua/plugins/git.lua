return {
  init = function(use)
    -- Simply the best git plugin around
    use { 'tpope/vim-fugitive' }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          attach_to_untracked = false,
        }
      end,
    }
  end
}
