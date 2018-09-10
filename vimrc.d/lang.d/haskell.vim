function! s:postHook()
  if executable('hie-wrapper')
    let g:LanguageClient_serverCommands['haskell'] = ['hie-wrapper', '+RTS', '-c', '-M1G', '-K1G', '-A16M', '-RTS', '--lsp']

    autocmd FileType haskell setlocal omnifunc=LanguageClient#complete

    autocmd FileType haskell inoremap <buffer> <silent>
          \ <C-Space> <c-o>:call LanguageClient#textDocument_signatureHelp()<CR>

    autocmd FileType haskell nnoremap <buffer> <silent>
          \ K :call LanguageClient#textDocument_hover()<CR>

    autocmd FileType haskell nnoremap <buffer> <silent>
          \ <leader>lh :call LanguageClient_textDocument_hover()<CR>
  endif
  let g:ale_linters['haskell'] = ['hie']
endfunction

call AddPostPluginHook(function('s:postHook'))
