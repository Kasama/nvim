if (has('nvim'))
  " Floobits for collaborative editing
  Plug 'floobits/floobits-neovim', { 'on': 'FloobitsLoadPlugin' }
endif

" must-have surround plugin
Plug 'tpope/vim-surround'

" Automatically load editorconfig configs
Plug 'editorconfig/editorconfig-vim'

" Live scrachpad
Plug 'metakirby5/codi.vim'

" Automatically close opened [('
Plug 'jiangmiao/auto-pairs'

" Test suite helper
Plug 'janko-m/vim-test'

" Multiple syntax
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting'

" Zeal documentation
Plug 'KabbAmine/zeavim.vim'
