if(has('nvim'))
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_serverCommands = {}
endif

function! s:postHook()
  " Javascript {
  if executable('javascript-typescript-stdio')
    let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['typescript'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['vue'] = ['javascript-typescript-stdio']

    autocmd FileType javascript,vue setlocal omnifunc=LanguageClient#complete

    autocmd FileType javascript,vue inoremap <buffer> <silent>
          \ <C-Space> <c-o>:call LanguageClient#textDocument_signatureHelp()<CR>

    autocmd FileType javascript,vue nnoremap <buffer> <silent>
          \ K :call LanguageClient#textDocument_hover()<CR>

    autocmd FileType javascript,vue nnoremap <buffer> <silent>
          \ <leader>lh :call LanguageClient_textDocument_hover()<CR>
  endif
  " }

  " Haskell {
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
  " }

  " Go {
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
  " }
endfunction

call AddPostPluginHook(function('s:postHook'))
