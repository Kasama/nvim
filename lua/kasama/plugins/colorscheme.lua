return {
  init = function(use)
    use {
      'navarasu/onedark.nvim',
      lazy = false,
      config = function()
        vim.cmd([[
        augroup HighlightTrailingWhitespaces
        autocmd!
        match ExtraWhiteSpaces /\s\+$/
        match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
        augroup END
        ]])

        require('onedark').setup({
          style = 'dark',
          toggle_style_key = '<Plug>toggleonedarkstyle',
          toggle_style_list = { 'dark', 'light' },
          transparent = false,
          code_style = {
            -- italic text will use OperatorMono font
            comments = 'italic',
            keywords = 'italic',
          },
          highlights = {
            ExtraWhiteSpaces = { bg = '#dddddd' },
            TreesitterContext = { bg = '#333333' },
          },
          diagnostics = {
            background = true,
            undercurl = false,
          },
        })

        require('onedark').load()

        vim.api.nvim_create_user_command('ColorschemeToggleLight', require('onedark').toggle, {})
      end
    }
  end
}
