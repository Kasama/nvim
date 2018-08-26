Plug 'jtratner/vim-flavored-markdown'

augroup Markdown "{
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END "}
