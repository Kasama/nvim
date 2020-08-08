Plug 'andys8/vim-elm-syntax'

augroup elmAutoformat
  " this one is which you're most likely to use?
  autocmd BufWritePre *.elm call CocAction('format')
augroup end
