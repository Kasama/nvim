Plug 'andys8/vim-elm-syntax'

augroup elmAutoformat
  " this one is which you're most likely to use?
  autocmd BufWritePre *.elm call CocAction('format')
  autocmd BufEnter *.elm setlocal shiftwidth=4 tabstop=4
augroup end
