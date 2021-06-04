let scripts_dir = fnamemodify(expand('$VIMRC'), ":p:h") . "/scripts"
if filereadable(scripts_dir . '/gofmt-safe')
  let gofmt_bin = scripts_dir . '/gofmt-safe'
else
  let gofmt_bin = 'gofmt'
end

augroup GoFormat "{
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
  autocmd FileType go autocmd BufWritePre <buffer> call CocAction('format')
augroup END "}

function! s:postHook()
  " Highlights
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go_code_completion_enabled = 0
  let g:go_gopls_enabled = 0
  let g:go_fmt_autosave = 1
  let g:go_gopls_options=['-remote=auto']
endfunction

call AddPostPluginHook(function('s:postHook'))
