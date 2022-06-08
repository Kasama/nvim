return {
  init = function(use)
    use {
      'rakr/vim-one',
      config = function()
        vim.opt.termguicolors = true

        vim.opt.background = 'dark'
        vim.cmd('colorscheme one')

        -- vim.fn['one#highlight']('ExtraWhiteSpaces', '222222', 'dddddd', 'none')
        vim.fn['one#highlight']('Folded', 'dddddd', '444444', 'bold')
        vim.fn['one#highlight']('ExtraWhiteSpaces', '222222', 'dddddd', 'none')

        vim.cmd([[
        augroup HighlightTrailingWhitespaces
        autocmd!
        match ExtraWhiteSpaces /\s\+$/
        match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
        augroup END
        ]])

        -- italic text will use OperatorMono font
        vim.cmd([[
        highlight vimLineComment gui=italic cterm=italic
        highlight vimCommand gui=italic cterm=italic
        highlight Comment gui=italic cterm=italic
        highlight Structure gui=italic cterm=italic
        highlight Typedef gui=italic cterm=italic
        ]])
      end
    }

  end
}
