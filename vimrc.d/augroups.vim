augroup VimRC "{
  autocmd!
  autocmd! BufWritePost *vimrc,init.vim source %
augroup END "}

augroup gitCommitSpell "{
  " Git commits.
  autocmd FileType gitcommit setlocal spell
augroup END "}

augroup PreviewOnBottom "{
  autocmd InsertEnter * set splitbelow
  autocmd InsertLeave * set splitbelow!
augroup END "}
