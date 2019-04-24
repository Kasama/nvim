" Plug 'w0rp/ale'

function! s:postHook()
  " Set this. Airline will handle the rest.
  let g:airline#extensions#ale#enabled = 1
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '--'
  let g:ale_linters = {}
endfunction

call AddPostPluginHook(function('s:postHook'))
