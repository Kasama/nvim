function! s:postHook()
  let g:ale_linters['haskell'] = ['hie']
endfunction

call AddPostPluginHook(function('s:postHook'))
