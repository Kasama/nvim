if(has('nvim'))
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
  Plug 'honza/vim-snippets'

  set updatetime=1000

  " Trigger completion with <M-space>
  inoremap <silent><expr> <M-space> coc#refresh()

  " Use tab for everything
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_global_extensions = [ 'coc-snippets', 'coc-elixir', 'coc-prettier',
                                \ 'coc-post', 'coc-lists', 'coc-imselect', 'coc-rust-analyzer', 'coc-explorer',
                                \ 'coc-highlight', 'coc-git', 'coc-eslint', 'coc-emoji', 'coc-actions',
                                \ 'coc-emmet', 'coc-yaml', 'coc-tsserver', 'coc-stylelint',
                                \ 'coc-solargraph', 'coc-jedi', 'coc-json', 'coc-elixir',
                                \ 'coc-html', 'coc-css', 'coc-diagnostic', 'coc-pairs', 'coc-docker']

  let g:coc_snippet_next = '<tab>'

  " Use Language Server Documentation
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Rename current Symbol
  nnoremap <silent> <leader>rn :call CocAction('rename')<CR>

  " Format
  nnoremap <silent> <leader>cf <Plug>(coc-format-selected)
  vnoremap <silent> <leader>cf <Plug>(coc-format-selected)

  " Find references
  nnoremap <silent> <leader>cref <Plug>(coc-references)

  " Goto Implementation
  nnoremap <silent> <leader>cimpl <Plug>(coc-implementation)

  " Code lens action
  nmap <silent> <leader>cl <Plug>(coc-codelens-action)
  nmap <silent> <F2> <Plug>(coc-codelens-action)

  " Jump To Definition on <C-]>
  nnoremap <silent> <C-]> :call <SID>jumpDefinition()<CR>

  function! s:jumpDefinition()
    let s:defaultJumpDefinition = ['help']
    if (index(s:defaultJumpDefinition, &filetype) >= 0)
      execute "normal! \<C-]>"
    else
      call CocAction('jumpDefinition')
    endif
  endfunction

  " Invoke generic CocAction
  noremap <silent> <C-Space> <ESC>:CocCommand actions.open<CR>

  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')
endif
