return {
  init = function(use)
    -- use {
    --   'rakr/vim-one',
    --   config = function()
    --     vim.opt.termguicolors = true

    --     vim.opt.background = 'dark'
    --     vim.cmd('colorscheme one')

    --     -- vim.fn['one#highlight']('ExtraWhiteSpaces', '222222', 'dddddd', 'none')
    --     vim.fn['one#highlight']('Folded', 'dddddd', '444444', 'bold')
    --     vim.fn['one#highlight']('ExtraWhiteSpaces', '222222', 'dddddd', 'none')

    --     vim.cmd([[
    --     augroup HighlightTrailingWhitespaces
    --     autocmd!
    --     match ExtraWhiteSpaces /\s\+$/
    --     match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
    --     augroup END
    --     ]])

    --     -- italic text will use OperatorMono font
    --     vim.cmd([[
    --     highlight vimLineComment gui=italic cterm=italic
    --     highlight vimCommand gui=italic cterm=italic
    --     highlight Comment gui=italic cterm=italic
    --     highlight Structure gui=italic cterm=italic
    --     highlight Typedef gui=italic cterm=italic
    --     ]])
    --   end
    -- }

    use {
      'navarasu/onedark.nvim',
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
          toggle_style_list = '',
          transparent = false,

          code_style = { -- italic text will use OperatorMono font
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
      end
    }

  end
}
