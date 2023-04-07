return {
  init = function(use)
    use {
      'tpope/vim-dadbod',
      dependencies = {
        'kristijanhusak/vim-dadbod-ui',
        'kristijanhusak/vim-dadbod-completion'
      },
      event = 'VeryLazy',
      config = function()
        vim.api.nvim_create_autocmd(
          "FileType",
          {
            group = vim.api.nvim_create_augroup("SQLCompletion", { clear = true }),
            pattern = { 'sql', 'mysql', 'plsql' },
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
  end,
}
