Plug 'tpope/vim-liquid'

function! CreateBlogPost(name) "{
  let date = strftime('%F')
  let filename = '_posts/' . date . '-' . a:name . '.md'
  execute 'e ' . filename
  execute "put! ='---'"
  execute "put ='layout: post'"
  execute "put ='title:'"
  execute "put ='date:'"
  execute "put ='comments: true'"
  execute "put ='categories:'"
  execute "put ='description:'"
  execute "put ='---'"
endfunction "}

function! InsertCurrentDate() "{
  execute "put =strftime('%F %H:%M:%S %z')"
  normal kJ
endfunction "}

augroup liquid "{
  autocmd! FileType liquid command! -nargs=* BlogPost call CreateBlogPost('<args>')
  autocmd! FileType liquid nnoremap <leader>da call InsertCurrentDate()
augroup END "}
