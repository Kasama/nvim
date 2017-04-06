syntax on

" Plug and plugins "{
"" Autoinstall Plug

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Autoinstall Plug

"" Init Plug
let plugged_path=expand('~/.config/nvim/plugged/')
call plug#begin(plugged_path)

"" Plugins
"Plug 'junegunn/vim-plug'
if (has('nvim'))
	Plug 'floobits/floobits-neovim'
endif
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
"Plug 'oblitum/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
"Plug 'ervandew/supertab'
Plug 'sentientmachine/erics_vim_syntax_and_color_highlighting'
Plug 'vim-scripts/a.vim', { 'for': [ 'c', 'cpp' ] }
Plug 'beyondmarc/opengl.vim', { 'for': ['c', 'cpp'] }
Plug 'beyondmarc/glsl.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
""Conflict with clang_complete
"Plug 'ap/vim-css-color', { 'for': [ 'html', 'css', 'sass', 'less', 'javascript' ] }
"Plug 'vim-scripts/OmniCppComplete', { 'for': ['ruby', 'python', 'yacc', 'lex', 'java'] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'erb'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'erb'] }
Plug 'moll/vim-node', { 'for': ['javascript', 'html'] }
"Plug 'mhartington/nvim-typescript', { 'for': ['typescript'] }
"Plug 'Shougo/deoplete.nvim'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'wookiehangover/jshint.vim', { 'for': ['javascript', 'html'] }
Plug 'chrisbra/NrrwRgn'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'othree/xml.vim'
Plug 'kien/ctrlp.vim'
Plug 'suan/vim-instant-markdown'
Plug 'tclem/vim-arduino'
Plug 'jvirtanen/vim-octave'
"Plug 'Chiel92/vim-autoformat'
Plug 'Kasama/vim-syntax-extra'
"Plug 'craigemery/vim-autotag'
"Plug 'vim-scripts/AutoComplPop'
"Plug 'Rip-Rip/clang_complete', { 'for': ['cpp', 'c', 'h'] }
"Plug 'bbchung/Clamp', { 'for': ['cpp', 'c', 'h'] }
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-crystal'
Plug 'elixir-lang/vim-elixir'
Plug 'adimit/prolog.vim'
Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'
Plug 'vim-scripts/CycleColor', { 'on': ['CycleColorNext', 'CycleColorPrev'] }
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

