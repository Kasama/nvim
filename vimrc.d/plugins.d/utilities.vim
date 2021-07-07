" Show a buffer with a narrower region from selection
" Plug 'chrisbra/NrrwRgn'

" Tabularize
Plug 'godlygeek/tabular'

" Multiple cursors support
Plug 'mg979/vim-visual-multi'
let g:VM_mouse_mappings = 1
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'

"Firefox nvim
" Plug 'glacambre/firenvim', { 'do': function('firenvim#install') }

" Grammar check
Plug 'rhysd/vim-grammarous'
let g:grammarous#use_location_list = 1
let g:grammarous#show_first_error = 0
" augroup Grammarous "{
"   autocmd!
"   autocmd! BufWritePost *.md GrammarousCheck
" augroup END "}

" Sort folds by first line
" Plug 'obreitwi/vim-sort-folds'

" Define custom operators
" Plug 'kana/vim-operator-user'
