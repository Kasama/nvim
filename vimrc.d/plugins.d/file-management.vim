" File tree as a side bar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

nnoremap \ :NERDTreeToggle<CR>

" Fuzzy Find with FZF or CtrlP
if (executable('fzf'))
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  if (executable('bat'))
    let $FZF_DEFAULT_OPTS = "--preview 'bat --style=plain --color=always --line-range :40 {}'"
  else
    let $FZF_DEFAULT_OPTS = "--preview 'head -40 {}'"
  endif
  if (has('nvim'))
    let $FZF_DEFAULT_OPTS = "--layout=reverse --inline-info --preview-window=40 " . $FZF_DEFAULT_OPTS
    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

    function! OpenFloatingWin()
      let height = &lines - 3
      let width = float2nr(&columns - (&columns * 2 / 10))
      let col = float2nr((&columns - width) / 2)
      let opts = {
            \ 'relative': 'editor',
            \ 'row': height * 0.3,
            \ 'col': col + 30,
            \ 'width': width * 2 / 3,
            \ 'height': height / 2
            \ }
      let buf = nvim_create_buf(v:false, v:true)
      let win = nvim_open_win(buf, v:true, opts)
      call setwinvar(win, '&winhl', 'Normal:Pmenu')
      setlocal buftype=nofile nobuflisted bufhidden=hide
             \ nonumber norelativenumber signcolumn=no
    endfunction
  endif

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
