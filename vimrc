syntax on

" Vundle and plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'


call vundle#end()
filetype plugin indent on
" Vundle Done

let mapleader = ","
let myVimRC = "/home/roberto/.vim/vimrc"

" Case insensitive :wq
command! W w
command! Q q
command! Wq wq
command! WQ wq

" Mappings
"" edit vimrc file
nnoremap <silent> <leader>ev :execute 'vsplit '.fnameescape(myVimRC)<CR>
nnoremap <silent> <leader>sv :execute 'source '.fnameescape(myVimRC)<CR>

"" Spelling
nnoremap <silent> <leader>l :set spell!<CR>

"" Create Fold
nnoremap <silent> <leader>f :set foldmethod=marker<CR> 

inoremap jk <Esc>
inoremap kj <Esc>

"" NerdTree
nnoremap \ :NERDTreeToggle<CR>

"" Call Devhelpe
augroup devHelp
	autocmd!
	au Filetype c nnoremap <silent> <leader>k :! devhelp -s "<cword>" 2>/dev/null 1>&2 &<CR><CR>
augroup end

"" Better Scrolling
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>

"" Tabs Commands
nnoremap <C-S><C-X> gt
nnoremap <C-S><C-Z> gT
"map <C-S><C-S> gT
nnoremap <C-S><C-W> :tabclose<CR>
nnoremap <C-S><C-O> :tabnew<CR>

"" Save current file
nnoremap <C-S> :w

"" Ident entire file
nnoremap <silent> <leader>= gg=G<C-O><C-O>

"" Toggle comment
nnoremap <silent><leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>

"" Bubble single lines"{
"" nmap <A-J> @=']e'<CR>
"" nmap <A-K> @='[e'<CR>

"" Bubble multiple lines
"" vmap <A-K> [egv
"" vmap <A-J> ]egv"}


" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>l

" Settings
set showmode
set whichwrap=b,s,<,>,[,]
set background=dark
set hlsearch
set foldmarker={,}
set foldmethod=marker
set foldlevelstart=99
set nu
set smartindent
set ignorecase smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set exrc
set secure
set relativenumber
set completeopt=menuone

"filetype on
"filetype plugin on
"filetype indent on

augroup syntaxes
	autocmd!
	au BufNewFile,BufRead *.asm set syntax=icmc
augroup end

augroup customTabs
	autocmd!
	au BufNewFile, BufRead *.rb :set tabstop=2
	au BufNewFile, BufRead *.rb :set shiftwidth=2
	au BufNewFile, BufRead *.rb :set softtabstop=2
	au BufNewFile, BufRead *.erb :set tabstop=2
	au BufNewFile, BufRead *.erb :set shiftwidth=2
	au BufNewFile, BufRead *.erb :set softtabstop=2
augroup end

if has('mouse')
	set mouse=a
endif

"Switch between block and I cursor when command/insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"Eclim on supertab
let g:SuperTabDefaultCompletionType = 'context'

"Eclim keybinds
augroup JavaEclim
	autocmd!
	au BufNewFile,BufRead *.java :nnoremap <silent> <leader>o :JavaImportOrganize<CR>
	au BufNewFile,BufRead *.java :nnoremap <silent> <leader>gi :JavaSearch<CR>
	au BufNewFile,BufRead *.java :nnoremap <silent> <leader>c :JavaCorrect<CR>
	au BufNewFile,BufRead *.java :nnoremap <silent> <leader>i :JavaImpl<CR>
augroup end

"Plantuml
augroup PlantUML
	autocmd!
	au BufNewFile,BufRead *.uml set syntax=plantuml
	au BufNewFile,BufRead *.puml set syntax=plantuml
augroup end


"CtrlP configs
let g:ctrlp_map = '<leader>p'
" disable caching
let g:ctrlp_use_caching=0

"Ultisnips using tab to expand
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"

"Disable default assembly checker
let g:syntastic_disabled_filetypes=['asm']
