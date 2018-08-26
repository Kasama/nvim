" True color support {
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
" }

" Colorscheme "{
augroup HighlightTrailingWhitespaces
  autocmd!
  match ExtraWhiteSpaces /\s\+$/
  match ExtraWhiteSpaces /\s\+$\| \+\ze\t/
augroup END
" }

" OperatorMono Colorscheme "{
" Discover Highlight section
function! GetHighlightSection() "{
  function! s:SyntaxId(modifier)
    return synIDattr(synID(line("."), col("."), a:modifier), "name")
  endfunction

  let highlightId = s:SyntaxId(1)
  let transId = s:SyntaxId(0)
  let loId = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")

  return "hi<" . highlightId . "> trans<" . transId . "> lo<" . loId . ">"
endfunction "}

nnoremap <leader>h :echo GetHighlightSection()<CR>

highlight vimLineComment gui=italic cterm=italic
highlight vimCommand gui=italic cterm=italic
highlight Comment gui=italic cterm=italic
highlight Structure gui=italic cterm=italic
highlight Typedef gui=italic cterm=italic
" }

" Highlight 81st column {
hi OverStepColumn guibg=#222222 ctermbg=4
call matchadd('OverStepColumn', '\%81v', 100)
" }
