"" Init Plug
let plugged_path=expand('~/.config/nvim/plugged/')
call plug#begin(plugged_path)

" Make it possible for plugins to add post-hooks
let g:postHooks = []
function! AddPostPluginHook(Func)
  call add(g:postHooks, a:Func)
endfunction

" Source all vim files in `dir` directory
function! s:loadFrom(dir)
  let s:pluginsGlob = a:dir . '/*.vim'
  let s:pluginsList = glob(s:pluginsGlob, v:false, v:true)

  for plugin in s:pluginsList
    execute 'source' plugin
  endfor
endfunction

let s:baseDir = fnamemodify(expand('<sfile>'), ':h') . '/'

call s:loadFrom(s:baseDir . 'plugins.d')
call s:loadFrom(s:baseDir . 'lang.d')

call plug#end()

" Execute all post-hooks
for Func in g:postHooks
  call Func()
endfor

" Remove post-hook list and function
unlet g:postHooks
delfunction AddPostPluginHook
