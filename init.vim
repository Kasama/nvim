syntax on

" Plug and plugins "{
" Setup Plug "{
"" Autoinstall Plug

if (has('nvim'))
  let vimPlugPath = '~/.config/nvim/autoload/plug.vim'
else
  let vimPlugPath = '~/.vim/autoload/plug.vim'
endif

if empty(glob(vimPlugPath))
  silent exe '!curl -fLo' vimPlugPath '--create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Init Plug
let plugged_path=expand('~/.config/nvim/plugged/')
call plug#begin(plugged_path)
"}

" Interface ==================================================================
Plug 'ryanoasis/vim-devicons'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/CycleColor', { 'on': ['CycleColorNext', 'CycleColorPrev'] }
Plug 'machakann/vim-highlightedyank'
"Plug 'nathanaelkane/vim-indent-guides' "Performance Issues

" Coding ======================================================================
if (has('nvim'))
  Plug 'floobits/floobits-neovim', { 'on': 'FloobitsLoadPlugin' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
else
  Plug 'Shougo/deoplete.nvim' |  Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
if (has('python'))
  Plug 'neomake/neomake'
    Plug 'Kasama/neomake-local-eslint.vim'
  Plug 'SirVer/ultisnips' ", { 'for': [ 'c', 'cpp', 'h' ] }
else
  Plug 'scrooloose/syntastic'
endif
Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c', 'h'] }
"Plug 'rhysd/vim-clang-format'
"Plug 'vhakulinen/neovim-intellij-complete-deoplete'
Plug 'idanarye/vim-vebugger', { 'for': ['cpp', 'c', 'h'] }
Plug 'metakirby5/codi.vim'
" TODO test this
" Plug 'turbio/bracey.vim' "HTML/CSS/Javascript

" Git =========================================================================
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" FileManagement ==============================================================
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Utilities ===================================================================
Plug 'chrisbra/NrrwRgn'
Plug 'terryma/vim-multiple-cursors'
Plug 'obreitwi/vim-sort-folds'
Plug 'kana/vim-operator-user'

"" Language/Framework support {

Plug 'junegunn/vader.vim', { 'for': [ 'vader' ] } "Vimscript
Plug 'slashmili/alchemist.vim', { 'for': [ 'elixir' ] } "Elixir
Plug 'lervag/vimtex', { 'for': [ 'tex', 'simpletex' ] } "LaTeX
Plug 'KabbAmine/zeavim.vim' "Zeal
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting' "Multiple syntax
Plug 'vim-scripts/a.vim', { 'for': [ 'c', 'cpp' ] } "C/Cpp
"Plug 'beyondmarc/opengl.vim', { 'for': ['c', 'cpp'] } "C/Cpp
"Plug 'beyondmarc/glsl.vim' "GLSL - OpenGL
Plug 'ap/vim-css-color' "CSS
" Plug 'akz92/vim-ionic2' "Ionic
Plug 'othree/html5.vim' "HTML
Plug 'mattn/emmet-vim' "HTML
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'erb'] } "Ruby
Plug 'tpope/vim-rails', { 'for': ['ruby', 'erb'] } "Rails
Plug 'moll/vim-node', { 'for': ['javascript', 'html'] } "NodeJS
Plug 'Quramy/tsuquyomi' "Typescript
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'mhartington/nvim-typescript'
"Plug 'wookiehangover/jshint.vim', { 'for': ['javascript', 'html'] }
 Plug 'HerringtonDarkholme/yats.vim' "Typescript
Plug 'othree/xml.vim' "XML
" Plug 'tclem/vim-arduino' "Arduino
" Plug 'jvirtanen/vim-octave' "Octave/Matlab
Plug 'Kasama/vim-syntax-extra', { 'for': ['c', 'cpp', 'yacc', 'lex'] }  "BISON, LEX, C, Cpp
" Plug 'rhysd/vim-crystal' "Crystal
Plug 'elixir-lang/vim-elixir' "Elixir
" Plug 'adimit/prolog.vim' "Prolog
" Plug 'rust-lang/rust.vim' "Rust
"Plug 'racer-rust/vim-racer' "Rust
Plug 'pangloss/vim-javascript' "Javascript
Plug 'galooshi/vim-import-js', { 'on': 'ImportJSLoadPlugin' } "Javascript
Plug 'mxw/vim-jsx' "JSX (React)
Plug 'posva/vim-vue' "Vue.JS
"Plug 'sekel/vim-vue-syntastic' "Vue.JS
"Plug 'm2mdas/phpcomplete-extended'
  "Plug 'm2mdas/phpcomplete-extended-laravel'
" Plug 'noahfrederick/vim-laravel', { 'for': [ 'php' ] } "Laravel PHP
"   Plug 'tpope/vim-dispatch'
"   if (has('nvim'))
"     Plug 'radenling/vim-dispatch-neovim'
"   endif
"   Plug 'tpope/vim-projectionist'
Plug 'noahfrederick/vim-composer', { 'for': [ 'php' ] } "PHP
Plug 'jtratner/vim-flavored-markdown' "Markdown
Plug 'chr4/nginx.vim' "NGINX
Plug 'martinda/Jenkinsfile-vim-syntax' "Jenkins
Plug 'hashivim/vim-terraform' "Terraform
Plug 'juliosueiras/vim-terraform-completion' "Terraform
Plug 'cespare/vim-toml' "Toml (Traefik/Cargo)
"" End Plugins }

call plug#end()
filetype plugin indent on
" Plug Done }

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
" nnoremap <silent> <leader>fc :ClangFormat<CR>

"" Generate tags file
nnoremap <silent> <leader>gt :!ctags -R .<CR>

"" edit and source vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Press Space to turn off highlighting and clear any message being displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>l

"" Using H and L as 0 and $
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $

"" Spelling
nnoremap <silent> <leader>l :setlocal spell!<CR>

"" Toggle listchars
nnoremap <silent> <leader>c :set list!<CR>

"" jk in insert mode exits it
inoremap jk <Esc>

"" NerdTree
nnoremap \ :NERDTreeToggle<CR>

"" Better Scrolling
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>

"" Save as root
cnoremap w!! w !sudo tee % > /dev/null

"" Ident entire file
nnoremap <silent> <leader>= gg=G<C-O><C-O>

"" Move between buffers
nnoremap <silent> <Tab><Tab> :bnext<CR>
nnoremap <silent> <S-Tab><S-Tab> :bprev<CR>
nnoremap <silent> <leader>bb :b#<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <C-\><C-\> :b#<CR>
nnoremap <silent> <C-\>q :bdelete<CR>
nnoremap <silent> <C-\><C-q> :bdelete<CR>

"" Copy and Paste from X env
"nnoremap <silent> <leader>y "+y
"nnoremap <silent> <leader>Y "+Y
"nnoremap <silent> <leader>p "+p
"nnoremap <silent> <leader>P "+P

"}

" Bubble single lines "{
nmap <A-J> @=']e'<CR>
nmap <A-K> @='[e'<CR>

" Bubble multiple lines
vmap <A-K> [egv
vmap <A-J> ]egv

"}

" True color support {
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
" }

" Colorscheme "{
set background=dark
colorscheme one
"call one#highlight('GroupName', 'foreground', 'background', 'style')
call one#highlight('Folded', 'dddddd', '444444', 'bold')
call one#highlight('ExtraWhiteSpaces', '222222', 'dddddd', 'none')

augroup HighlightTrailingWhitespaces
  autocmd!
  match ExtraWhiteSpaces /\s\+$/
  match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
augroup END
" }

" Highlight 81st column {
hi OverStepColumn guibg=#222222 ctermbg=4
call matchadd('OverStepColumn', '\%81v', 100)
" }

" Enable mouse "{
if has('mouse')
  set mouse=a
endif
"}

" Settings "{
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
"}

" AuGroups "{
augroup Vue "{
  autocmd!
  au Filetype vue set syntax=html
augroup END "}

augroup devHelp "{
  autocmd!
  au Filetype c nnoremap <silent> <buffer> <leader>k :! devhelp -s "<cword>" 2>/dev/null 1>&2 &<CR><CR>
augroup END "}

augroup Rust "{
  autocmd!
  au BufNewFile,BufRead *.rs nnoremap <leader>rr :RustRun<CR>
  au BufNewFile,BufRead *.rs nnoremap <leader>cr :!cargo run<CR>
  au BufNewFile,BufRead *.rs nnoremap <leader>ct :!cargo test<CR>
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
  au FileType html setlocal tabstop=2
  au FileType html setlocal shiftwidth=2
  au FileType html setlocal softtabstop=2
  au FileType html setlocal expandtab
  au FileType yacc setlocal expandtab
augroup END "}

augroup comments "{
  autocmd!
  au FileType c,h,cpp,hpp nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
  au FileType java nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
  au FileType javascript nnoremap <silent> <buffer> <leader>q I//<esc>:s/\v(\/\/+)\1+//e<CR>
  au FileType ruby,eruby nnoremap <silent> <buffer> <leader>q I#<esc>:s/\v(#+)\1+//e<CR>
  au FileType python nnoremap <silent> <buffer> <leader>q I#<esc>:s/\v(#+)\1+//e<CR>
  au FileType html nnoremap <silent> <buffer> <leader>q :call emmet#toggleComment()<CR>
  au Syntax vim nnoremap <silent> <buffer> <leader>q I"<esc>:s/\v("+)\1+//e<CR>
augroup END "}

" augroup JavaEclim "{
"   autocmd!
"   au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>o :JavaImportOrganize<CR>
"   au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>gi :JavaSearch<CR>
"   au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>c :JavaCorrect<CR>
"   au BufNewFile,BufRead *.java nnoremap <silent> <buffer> <leader>i :JavaImpl<CR>
" augroup END "}

" augroup PlantUML "{
"   autocmd!
"   au BufNewFile,BufRead *.uml setlocal syntax=plantuml
"   au BufNewFile,BufRead *.puml setlocal syntax=plantuml
"   au BufNewFile,BufRead *.puml nnoremap <silent> <leader>w :!plantuml -tsvg %<CR><CR>
" augroup END "}

augroup SpecialCTAGS "{
  autocmd!
  autocmd! BufRead,BufNewFile *.rb unmap <leader>gt
  autocmd! BufRead,BufNewFile *.rb nnoremap <leader>gt :!ctags -R . $(bundle list --paths)<CR>
augroup END"}

" augroup tabBehaviour "{
"   autocmd!
"   au BufRead,BufNewFile *.c let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
"   au BufRead,BufNewFile *.cpp let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
"   au BufRead,BufNewFile *.h let g:SuperTabDefaultCompletionType = '<C-X><C-U>'
" augroup END "}

augroup VimRC "{
  autocmd!
  autocmd! BufWritePost *vimrc source %
augroup END "}

augroup gitCommitSpell "{
  " Git commits.
  autocmd FileType gitcommit setlocal spell
augroup END "}

" augroup arduino "{
"   au BufRead,BufNewFile *.pde set filetype=arduino
"   au BufRead,BufNewFile *.ino set filetype=arduino
" augroup END "}

" augroup octave "{
"   au BufRead,BufNewFile *.m, set filetype=octave
"   "au FileType octave setlocal keywordprg=info\ octave\ --vi-keys\ --index-search
"   au FileType octave map <buffer> <f5> <esc>:w<cr>:!octave --no-gui -q --persist %<cr>
" augroup END "}

augroup Markdown "{
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END "}

augroup PreviewOnBottom "{
  autocmd InsertEnter * set splitbelow
  autocmd InsertLeave * set splitbelow!
augroup END "}

"}

" Plugin related configs "{

" HTML EMMET {
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-s>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
autocmd FileType html,css,javascript.jsx EmmetInstall
" }

" Language Server Configs {
let g:LanguageClient_serverCommands = {
  \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
  \ 'vue': ['tcp://127.0.0.1:2089'],
  \ }
" }

" deoplete config {
" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
let b:deoplete_disable_auto_complete=1
let g:deoplete_disable_auto_complete=1
call deoplete#custom#buffer_option('auto_complete', v:false)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set sources
let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['LanguageClient']
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources.c = ['LanguageClient']
let g:deoplete#sources.vim = ['vim']

" deoplete-racer config
let g:deoplete#sources#rust#racer_binary='/Users/aenayet/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path= '/Users/aenayet/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" }

" vim-devicons config {
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = 'V'
" }

" vim-airline config {
let g:airline_powerline_fonts = 1
" let g:airline_theme='base16_grayscale'
let g:airline_theme='one'
" Tabline
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t' "Show only filename
let g:airline#extensions#tabline#formatter = 'unique_tail'
" }

" Eclim on supertab "{
" "let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = '<c-p>'
" let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" "}

" Ack.vim using The Silver Searcher (Ag) "{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" enable caching
let g:ctrlp_use_caching=1
"}

" Vim-Ruby/Rails {
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"}

"Ultisnips using tab to expand "{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"
"}

" Rust config "{
let g:racer_cmd = $HOME . "/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src"
"}

" Syntastic "{
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }
" C
let g:syntastic_c_compiler_options = '-std=c99'
" Javascript and VueJS checkers
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = g:syntastic_javascript_checkers
" ASM
let g:syntastic_disabled_filetypes=['asm']

" Use local eslint when possible
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
    let g:syntastic_vue_eslint_exec = local_eslint
endif

" Typescript
let g:syntastic_typescript_checkers = ['tslint', 'tsuquyomi']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_aggregate_errors = 1
" Rust
let g:syntastic_rust_checkers = ['rustc']
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

" JavascriptX "{
  let g:jsx_ext_required = 0
"}

" Neomake "{
  let g:neomake_java_enabled_makers = ['gradle']
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_jsx_enabled_makers = g:neomake_javascript_enabled_makers
  let g:neomake_vue_enabled_makers = g:neomake_javascript_enabled_makers
  let g:neomake_elixir_enabled_makers = ['mix', 'credo']
  call neomake#configure#automake('rw', 1000)
"}

" PHP Complete Extended "{
  "augroup phpcomplete_extended "{
  " autocmd!
  " autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
  "augroup END "}

  let g:phpcomplete_index_composer_command='composer'
"}

"}

" Functions {
" Ultisnips vs. YouCompleteMe Tab {
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
"}

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
