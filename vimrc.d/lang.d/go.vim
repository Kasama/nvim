Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

augroup GoFormat "{
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
augroup END "}

function! s:postHook()
  " Highlights
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
endfunction

call AddPostPluginHook(function('s:postHook'))
