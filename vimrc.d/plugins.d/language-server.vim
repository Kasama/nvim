if(has('nvim'))
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}

  set updatetime=1000

  " Trigger completion with <c-space>
  inoremap <silent><expr> <c-space> coc#refresh()

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

  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')
endif
