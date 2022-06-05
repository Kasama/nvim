Plug 'neovim/nvim-lspconfig'
Plug 'MunifTanjim/nui.nvim'
Plug 'ShinKage/idris2-nvim'

if (has('nvim'))

  function! s:postHook()
  lua <<EOF
  local opts = {
  }

  require('idris2').setup(opts)
EOF
  endfunction

  call AddPostPluginHook(function('s:postHook'))

endif
