set laststatus=2
set noshowmode
set whichwrap=b,s,<,>,[,]
exec "set listchars=tab:\uBB\uA0,trail:¶,space:\uB7"
set hlsearch
set foldmarker={,}
set foldmethod=marker
set foldlevelstart=99
set smartindent
set ignorecase smartcase
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set exrc
set secure
set hidden
set number
set relativenumber
"set completeopt=menuone
set completeopt=longest,menu,preview
set lazyredraw
set title
if (has('nvim'))
  set inccommand=split
endif
