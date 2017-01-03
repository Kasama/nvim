syntax on

" Plug and plugins "{

" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall | source $MYVIMRC
" endif

"" Autoinstall Plug

"" Init Plug
let plugged_path=expand('~/.config/nvim/plugged/')
call plug#begin(plugged_path)

"" Plugins
Plug 'junegunn/vim-plug'
Plug 'floobits/floobits-neovim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting'
Plug 'vim-scripts/a.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
""Conflict with clang_complete
Plug 'ap/vim-css-color', { 'for': [ 'html', 'css', 'sass', 'less', 'js' ] }
Plug 'vim-scripts/OmniCppComplete', { 'for': ['ruby', 'python', 'yacc', 'lex', 'java'] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'erb'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'erb'] }
Plug 'chrisbra/NrrwRgn'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'othree/xml.vim'
Plug 'kien/ctrlp.vim'
"Plug 'suan/vim-instant-markdown'
Plug 'tclem/vim-arduino'
Plug 'jvirtanen/vim-octave'
"Plug 'Chiel92/vim-autoformat'
Plug 'Kasama/vim-syntax-extra'
"Plug 'craigemery/vim-autotag'
"Plug 'vim-scripts/AutoComplPop'
Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c', 'h'] }
"Plug 'bbchung/Clamp', { 'for': ['cpp', 'c', 'h'] }
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-crystal'
Plug 'elixir-lang/vim-elixir'
Plug 'adimit/prolog.vim'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'vim-scripts/CycleColor'
"Plug 'rhysd/vim-clang-format'
"Plug 'vhakulinen/neovim-intellij-complete-deoplete'
"" End Plugins

call plug#end()
filetype plugin indent on
" Plug Done

"" If Plug was just installed, install all plugins
"if isPlugUpdated == 0
"	echo "Installing Plugins, please ignore key map error messages"
"	echo ""
"	:BundleInstall!
"endif "}

" Leader key "{
let mapleader = ","
let localleader = ";"
"}

" Case insensitive :wq "{
command! W w
command! Q q
command! Wq wq
command! WQ wq "}

" Mappings "{
"" Consider long lines separate lines
nnoremap j gj
nnoremap k gk
nnoremap <UP> g<UP>
nnoremap <DOWN> g<DOWN>

"" Reformat code
nnoremap <silent> <leader>fc :ClangFormat<CR>

"" Generate tags file
nnoremap <silent> <leader>gt :!ctags -R .<CR>

"" edit and source vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>l

"" Using H and L as 0 and $
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $

"" Spelling
nnoremap <silent> <leader>l :setlocal spell!<CR>

"" Create Fold
nnoremap <silent> <leader>f :set foldmethod=marker<CR>

"" Toggle listchars
nnoremap <silent> <leader>c :set list!<CR>

"" jk in insert mode exits it
inoremap jk <Esc>

"" NerdTree
nnoremap \ :NERDTreeToggle<CR>

"" Better Scrolling
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>

"" Tabs Commands
"nnoremap <C-S><C-X> gt
"nnoremap <C-S><C-Z> gT
""map <C-S><C-S> gT
"nnoremap <C-S><C-W> :tabclose<CR>
"nnoremap <C-S><C-O> :tabnew<CR>

"" Save current file
nnoremap <C-S> :w<CR>

"" Save as root
cmap w!! w !sudo tee % > /dev/null

"" Ident entire file
nnoremap <silent> <leader>= gg=G<C-O><C-O>

"" Move between buffers
nnoremap <silent> <Tab><Tab> :bnext<CR>
nnoremap <silent> <S-Tab><S-Tab> :bprev<CR>
nnoremap <silent> <C-\><C-\> :b#<CR>
nnoremap <silent> <C-\>q :bdelete<CR>

"" switch to C90 comment style
nnoremap <silent> <leader>fcs 02f/r*A */<ESC>

"" Copy and Paste from X env
"nnoremap <silent> <leader>y "+y
"nnoremap <silent> <leader>Y "+Y
"nnoremap <silent> <leader>p "+p
"nnoremap <silent> <leader>P "+P

"}

" Bubble single lines "{
nmap <M-J> @=']e'<CR>
nmap <M-K> @='[e'<CR>

" Bubble multiple lines
vmap <M-K> [egv
vmap <M-J> ]egv "}

" Colorscheme "{
	"colorscheme molokaiyo
	colorscheme kasama
" }

" Highlight 81st column {
	hi OverStepColumn ctermbg=4
	call matchadd('OverStepColumn', '\%81v', 100)
" }

" Settings "{
set tags=./tags;
set laststatus=2
set noshowmode
set whichwrap=b,s,<,>,[,]
exec "set listchars=tab:\uBB\uA0,trail:¶,space:\uB7"
set background=dark
set hlsearch
set foldmarker={,}
set foldmethod=marker
set foldlevelstart=99
set smartindent
set ignorecase smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set exrc
set secure
set hidden
set nu
set relativenumber
"set completeopt=menuone
set completeopt=longest,menu,preview
set lazyredraw
"}

" AuGroups "{
augroup devHelp "{
	autocmd!
	au Filetype c nnoremap <silent> <buffer> <leader>k :! devhelp -s "<cword>" 2>/dev/null 1>&2 &<CR><CR>
augroup END "}

augroup Rails "{
	autocmd!
	au BufNewFile,BufRead *.erb nnoremap <leader>rc :Rcontroller<CR>
	au BufNewFile,BufRead *.rb nnoremap <leader>rc :Rcontroller<CR>
	au BufNewFile,BufRead *.js nnoremap <leader>rc :Rcontroller<CR>
	au BufNewFile,BufRead *.erb nnoremap <leader>rv :Rview<CR>
	au BufNewFile,BufRead *.rb nnoremap <leader>rv :Rview<CR>
	au BufNewFile,BufRead *.js nnoremap <leader>rv :Rview<CR>
	au BufNewFile,BufRead *.erb nnoremap <leader>rm :Rmodel<CR>
	au BufNewFile,BufRead *.rb nnoremap <leader>rm :Rmodel<CR>
	au BufNewFile,BufRead *.js nnoremap <leader>rm :Rmodel<CR>
augroup END "}

augroup Ruby "{
	autocmd!
	au BufNewFile,BufRead *.rb set completefunc=rubycomplete#Complete
	au BufNewFile,BufRead *.rb let g:syntastic_ruby_checkers=['rubocop']
augroup END "}

augroup htmlAbrrevs "{
	autocmd!
	autocmd BufNewFile,BufRead *.html iabbrev << &lt;
	autocmd BufNewFile,BufRead *.html iabbrev >> &gt;
augroup END "}

augroup syntaxes "{
	autocmd!
	au BufNewFile,BufRead *.asm setlocal syntax=icmc
	au BufNewFile,BufRead *.ws set filetype=ws
augroup END "}

augroup customTabs "{
	autocmd!
	au BufNewFile,BufRead *.rb setlocal tabstop=2
	au BufNewFile,BufRead *.rb setlocal shiftwidth=2
	au BufNewFile,BufRead *.rb setlocal softtabstop=2
	au BufNewFile,BufRead *.rb setlocal expandtab
	au BufNewFile,BufRead *.erb setlocal tabstop=2
	au BufNewFile,BufRead *.erb setlocal shiftwidth=2
	au BufNewFile,BufRead *.erb setlocal softtabstop=2
	au BufNewFile,BufRead *.erb setlocal expandtab
	au FileType haskell setlocal tabstop=8
	au FileType haskell setlocal shiftwidth=8
	au FileType haskell setlocal softtabstop=8
	au FileType haskell setlocal expandtab
augroup END "}

augroup HighlightTrailingWhitespaces "{
	autocmd!
	match ExtraWhiteSpaces /\s\+$/
	match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
augroup END "}

augroup comments "{
	autocmd!
	au BufNewFile,BufRead *.c nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
	au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
	au BufNewFile,BufRead *.js nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
	au BufNewFile,BufRead *.rb nnoremap <silent> <buffer> <leader>q I#<esc>:s/\v(#+)\1+//e<CR>
	au BufNewFile,BufRead *.py nnoremap <silent> <buffer> <leader>q I#<esc>:s/\v(#+)\1+//e<CR>
	au Syntax vim nnoremap <silent> <buffer> <leader>q I"<esc>:s/\v("+)\1+//e<CR>
augroup END "}

augroup JavaEclim "{
	autocmd!
	au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>o :JavaImportOrganize<CR>
	au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>gi :JavaSearch<CR>
	au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>c :JavaCorrect<CR>
	au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>i :JavaImpl<CR>
augroup END "}

augroup PlantUML "{
	autocmd!
	au BufNewFile,BufRead *.uml setlocal syntax=plantuml
	au BufNewFile,BufRead *.puml setlocal syntax=plantuml
	au BufNewFile,BufRead *.puml nnoremap <silent> <leader>w :!plantuml -tsvg %<CR><CR>
augroup END "}

augroup SpecialCTAGS "{
	autocmd!
	autocmd! BufRead,BufNewFile *.rb unmap <leader>gt
	autocmd! BufRead,BufNewFile *.rb nnoremap <leader>gt :!ctags -R . $(bundle list --paths)<CR>
augroup END"}

augroup tabBehaviour "{
	autocmd!
	au BufRead,BufNewFile *.c let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
	au BufRead,BufNewFile *.cpp let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
	au BufRead,BufNewFile *.h let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
augroup END "}

augroup VimRC "{
	autocmd!
	autocmd! BufWritePost *vimrc source %
augroup END "}

augroup commitSpell "{
	" Git commits.
	autocmd FileType gitcommit setlocal spell
augroup END "}

augroup arduino "{
	au BufRead,BufNewFile *.pde set filetype=arduino
	au BufRead,BufNewFile *.ino set filetype=arduino
augroup END "}

augroup octave "{
au BufRead,BufNewFile *.m, set filetype=octave
"au FileType octave setlocal keywordprg=info\ octave\ --vi-keys\ --index-search
au FileType octave map <buffer> <f5> <esc>:w<cr>:!octave --no-gui -q --persist %<cr>
augroup END "}

"}

" Enable mouse "{
if has('mouse')
	set mouse=a
endif
"}

" Plugin related configs "{

" deoplete config {
let g:deoplete#enable_at_startup = 1
" }

" vim-airline config {
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_grayscale'
" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' "Show only filename
" }

"Eclim on supertab "{
"let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
let g:SuperTabDefaultCompletionType = 'context'
"}

"CtrlP configs "{
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'some_bad_symbolic_links',
	\ }

" enable caching
let g:ctrlp_use_caching=1
"}

"Ultisnips using tab to expand "{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
"}

"Disable default assembly checker "{
let g:syntastic_disabled_filetypes=['asm']
"}

" Rust config "{
	let g:racer_cmd = $HOME . "/.cargo/bin/racer"
	let $RUST_SRC_PATH="/usr/src/rust/src"
"}

" Syntastic "{
	let g:syntastic_c_compiler_options = '-std=c90'
"}

" Clang_Complete "{
	let g:clang_snippets = 1
	let g:clang_snippets_engine = 'clang_complete'
	let g:clang_close_preview = 1
	let g:clang_complete_auto = 1
	let g:clang_complete_copen = 0
	let g:clang_complete_macros = 1
	let g:clang_use_library=1
	let g:clang_library_path="/usr/lib/"
	let g:clang_periodic_quickfix=0 " update quickfix periodically
	let g:clang_hl_errors = 0
	set completeopt=menu,longest
"}

"}

"" Functions {
" Bubble lines {
function! s:Move(cmd, count, map) abort
	normal! m`
	silent! exe 'move'.a:cmd.a:count
	norm! ``
	silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
	normal! m`
	silent! exe "'<,'>move'<--".a:count
	norm! ``
	silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
endfunction
function! s:MoveSelectionDown(count) abort

	normal! m`
	norm! ``
	exe "'<,'>move'>+".a:count
	silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveSelectionUp
xmap ]e <Plug>unimpairedMoveSelectionDown
"}
"}
