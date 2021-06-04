Plug 'tsandall/vim-rego'

let g:neoformat_rego_opafmt = {
            \ 'exe': 'opa',
            \ 'args': ['fmt'],
            \ 'replace': 0,
            \ 'stdin': 1,
            \ 'env': [],
            \ 'valid_exit_codes': [0],
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_rego = ['opafmt']

augroup opafmt
  autocmd!
  autocmd BufWritePre *.rego Neoformat
augroup END
