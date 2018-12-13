" Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim' "Typescript
Plug 'pangloss/vim-javascript' "Javascript
Plug 'galooshi/vim-import-js', { 'on': 'ImportJSLoadPlugin' } "Javascript
Plug 'mxw/vim-jsx' "JSX (React)
Plug 'posva/vim-vue' "Vue.JS
Plug 'moll/vim-node', { 'for': ['javascript', 'html'] } "NodeJS

function! s:postHook()
  let g:user_emmet_settings['javascript.jsx'] = {'extends' : 'jsx'}

  let g:jsx_ext_required = 0
endfunction

call AddPostPluginHook(function('s:postHook'))
