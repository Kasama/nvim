"" jk in insert mode exits it
inoremap jk <Esc>

"" Save as root
cnoremap w!! w !sudo tee % > /dev/null

"" Consider long lines separate lines
nnoremap j gj
nnoremap k gk
nnoremap <UP> g<UP>
nnoremap <DOWN> g<DOWN>

"" Generate tags file
nnoremap <silent> <leader>gt :!ctags -R .<CR>

"" edit and source vimrc file
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" Press Space to turn off highlighting and clear any message being displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>l

"" Using H and L as 0 and $
nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $

"" Spelling
nnoremap <silent> <leader>l :setlocal spell!<CR>

"" Toggle listchars
nnoremap <silent> <leader>c :set list!<CR>

"" Better Scrolling
nnoremap <C-J> <C-E>
nnoremap <C-K> <C-Y>

"" Ident entire file
nnoremap <silent> <leader>= gg=G<C-O><C-O>

"" Move between buffers
nnoremap <silent> <Tab><Tab> :bnext<CR>
nnoremap <silent> <S-Tab><S-Tab> :bprev<CR>
nnoremap <silent> <leader>bb :b#<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <C-\><C-\> :b#<CR>
nnoremap <silent> <C-\>q :bdelete<CR>
nnoremap <silent> <C-\><C-q> :bdelete<CR>

" Copy and Paste from X env
nnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>Y "+Y
vnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>Y "+Y
"nnoremap <silent> <leader>p "+p
"nnoremap <silent> <leader>P "+P
