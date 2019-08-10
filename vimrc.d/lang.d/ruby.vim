Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'erb'] } "Ruby
Plug 'tpope/vim-rails', { 'for': ['ruby', 'erb'] } "Rails

augroup Rails "{
  autocmd!
  au BufNewFile,BufRead *.erb nnoremap <leader>rc :Rcontroller<CR>
  au BufNewFile,BufRead *.rb nnoremap <leader>rc :Rcontroller<CR>
  au BufNewFile,BufRead *.js nnoremap <leader>rc :Rcontroller<CR>
  au BufNewFile,BufRead *.erb nnoremap <leader>rv :Rview<CR>
  au BufNewFile,BufRead *.rb nnoremap <leader>rv :Rview<CR>
  au BufNewFile,BufRead *.js nnoremap <leader>rv :Rview<CR>
  au BufNewFile,BufRead *.erb nnoremap <leader>rm :Rmodel<CR>
  au BufNewFile,BufRead *.rb nnoremap <leader>rm :Rmodel<CR>
  au BufNewFile,BufRead *.js nnoremap <leader>rm :Rmodel<CR>
augroup END "}

augroup SpecialCTAGS "{
  autocmd!
  autocmd! BufRead,BufNewFile *.rb unmap <leader>gt
  autocmd! BufRead,BufNewFile *.rb nnoremap <leader>gt :!ctags -R . $(bundle list --paths)<CR>
augroup END"}

augroup ERubyTags "{
  autocmd!
  autocmd! BufRead,BufNewFile *.erb inoremap %= <%= %><ESC>F=a
  autocmd! BufRead,BufNewFile *.erb inoremap %% <% -%><ESC>F-hi
augroup END"}
