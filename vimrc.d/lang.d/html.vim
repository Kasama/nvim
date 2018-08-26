augroup htmlAbrrevs "{
  autocmd!
  autocmd BufNewFile,BufRead *.html iabbrev << &lt;
  autocmd BufNewFile,BufRead *.html iabbrev >> &gt;
augroup END "}

" TODO test this
" Plug 'turbio/bracey.vim' "HTML/CSS/Javascript

Plug 'mattn/emmet-vim' "HTML

  let g:user_emmet_install_global = 0
  let g:user_emmet_leader_key='<C-s>'
  let g:user_emmet_settings = {}

  autocmd FileType html,css,javascript.jsx EmmetInstall

Plug 'othree/html5.vim' "HTML
Plug 'ap/vim-css-color' "CSS
