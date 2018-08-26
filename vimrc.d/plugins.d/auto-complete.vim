if (has('nvim'))
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim' |  Plug 'roxma/nvim-yarp' | Plug 'roxma/vim-hug-neovim-rpc'
endif

function! s:postHook()
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  " Disable the candidates in Comment/String syntaxes.
  call deoplete#custom#source('_',
        \ 'disabled_syntaxes', ['Comment', 'String'])

  " Close preview window after completion
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endfunction

call AddPostPluginHook(function('s:postHook'))
