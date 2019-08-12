" File tree as a side bar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

nnoremap \ :NERDTreeToggle<CR>

" Fuzzy Find with FZF or CtrlP
if (executable('fzf'))
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  if (!executable('ag'))
    Plug 'mileszs/ack.vim'
  endif

  nnoremap <silent> <leader>a :Ag<Space>
  nnoremap <silent> <leader>p :GFiles<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
else
  Plug 'mileszs/ack.vim'
  Plug 'ctrlpvim/ctrlp.vim'

  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

  let g:ctrlp_map = '<leader>p'
  let g:ctrlp_working_path_mode = 'ra'

  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  " enable caching
  let g:ctrlp_use_caching=1
endif

" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
