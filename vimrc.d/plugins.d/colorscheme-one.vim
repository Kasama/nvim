Plug 'rakr/vim-one'

function! s:postHook()
  set background=dark
  colorscheme one
  "call one#highlight('GroupName', 'foreground', 'background', 'style')
  call one#highlight('Folded', 'dddddd', '444444', 'bold')
  call one#highlight('ExtraWhiteSpaces', '222222', 'dddddd', 'none')
endfunction

call AddPostPluginHook(function("s:postHook"))
