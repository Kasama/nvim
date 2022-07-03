return {
  init = function(use)
    use {
      'tpope/vim-dadbod',
      requires = {
        'kristijanhusak/vim-dadbod-completion'
      },
      -- after = { 'hrsh7th/nvim-cmp' },
      config = function()
        vim.api.nvim_create_autocmd(
          "FileType",
          {
            group = vim.api.nvim_create_augroup("SQLCompletion", { clear = true }),
            pattern = { 'sql','mysql','plsql' },
            callback = function()
              require('cmp').setup.buffer({
                sources = {
                  { name = 'vim-dadbod-completion' }
                }
              })
            end,
          }
        )
      end,
    }
    use { 'kristijanhusak/vim-dadbod-ui' }
  end,
}
