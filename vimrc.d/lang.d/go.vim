if executable('go-langserver')
  let g:LanguageClient_serverCommands['go'] = ['go-langserver', '-gocodecompletion']

  autocmd FileType go setlocal omnifunc=LanguageClient#complete

  autocmd FileType go inoremap <buffer> <silent>
        \ <C-Space> <c-o>:call LanguageClient#textDocument_signatureHelp()<CR>

  autocmd FileType go nnoremap <buffer> <silent>
        \ K :call LanguageClient#textDocument_hover()<CR>

  autocmd FileType go nnoremap <buffer> <silent>
        \ <leader>lh :call LanguageClient_textDocument_hover()<CR>
endif
