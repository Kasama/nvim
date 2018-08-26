Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim' "Typescript
Plug 'pangloss/vim-javascript' "Javascript
Plug 'galooshi/vim-import-js', { 'on': 'ImportJSLoadPlugin' } "Javascript
Plug 'mxw/vim-jsx' "JSX (React)
Plug 'posva/vim-vue' "Vue.JS
Plug 'moll/vim-node', { 'for': ['javascript', 'html'] } "NodeJS

function! s:postHook()
  if executable('javascript-typescript-stdio')
    let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['javascript'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['typescript'] = ['javascript-typescript-stdio']
    let g:LanguageClient_serverCommands['vue'] = ['javascript-typescript-stdio']

    autocmd FileType javascript,vue setlocal omnifunc=LanguageClient#complete

    autocmd FileType javascript,vue inoremap <buffer> <silent>
          \ <C-Space> <c-o>:call LanguageClient#textDocument_signatureHelp()<CR>

    autocmd FileType javascript,vue nnoremap <buffer> <silent>
          \ K :call LanguageClient#textDocument_hover()<CR>

    autocmd FileType javascript,vue nnoremap <buffer> <silent>
          \ <leader>lh :call LanguageClient_textDocument_hover()<CR>
  endif

  let g:user_emmet_settings['javascript.jsx'] = {'extends' : 'jsx'}

  let g:jsx_ext_required = 0
endfunction

call AddPostPluginHook(function('s:postHook'))
