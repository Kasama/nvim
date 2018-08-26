if(has('nvim'))
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  let g:LanguageClient_autoStart = 1
  let g:LanguageClient_serverCommands = {}
endif
