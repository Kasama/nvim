syntax on

" File Loading Function "{
let s:vim_modules_dir = fnamemodify(expand("<sfile>"), ":h").'/vimrc.d/'
function! s:load(file)
  let sourcePath = s:vim_modules_dir . a:file . '.vim'
  if !empty(glob(sourcePath))
    execute 'source' sourcePath
  endif
endfunction
"}

" Leader Key
let mapleader = "," | let localleader = ";"

" Load Plugins
call s:load('vim-plug')
call s:load('plugins')

" Mappings
call s:load('mappings')

" Augroups
call s:load('augroups')

" Colorscheme
call s:load('colorscheme')

" Mouse Support
call s:load('mouse')

" Settings
call s:load('settings')

" Case insensitive :wq "{
command! W w
command! Q q
command! Wq wq
command! WQ wq "}
