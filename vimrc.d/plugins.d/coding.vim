if (has('nvim'))
  " Floobits for collaborative editing
  Plug 'floobits/floobits-neovim', { 'on': 'FloobitsLoadPlugin' }
endif

" must-have surround plugin
Plug 'tpope/vim-surround'

" Automatically load editorconfig configs
Plug 'editorconfig/editorconfig-vim'

" Live scrachpad
Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

" Automatically close opened [('
Plug 'Kasama/auto-pairs' | let g:AutoPairsEnableParensDecorators = 1

" Test suite helper
Plug 'janko-m/vim-test'

" Multiple syntax
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting'

" Zeal documentation
Plug 'KabbAmine/zeavim.vim'

" Rainbow Parens
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
\  'separately': {
\    'liquid': 0
\  }
\}
