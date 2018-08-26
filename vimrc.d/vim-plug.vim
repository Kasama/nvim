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
