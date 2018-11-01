" Cycle between colorschemes
Plug 'vim-scripts/CycleColor', { 'on': ['CycleColorNext', 'CycleColorPrev'] }

" Hightlight yanked text
Plug 'machakann/vim-highlightedyank'

" Pretty icons for NerdTree, Airline, etc
Plug 'ryanoasis/vim-devicons'

" Airline top and bottom status bars
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'guns/xterm-color-table.vim', { 'on': ['XtermColorTable'] }
" Airline Config {

let g:airline_powerline_fonts = 1
" let g:airline_theme='base16_grayscale'
let g:airline_theme='one'
" Tabline
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t' "Show only filename
let g:airline#extensions#tabline#formatter = 'unique_tail'
"}
