local mappings = {
  -- jk returns to normal mode from insert
  {'i', 'jk', '<ESC>'},

  -- save as root to avoid having to open VIM as root
  {'c', 'w!!', 'w !sudo tee % >/dev/null'},

  -- consider visually split lines as different lines
  {'n', 'j', 'gj'},
  {'n', 'k', 'gk'},
  {'n', '<UP>', 'g<UP>'},
  {'n', '<DOWN>', 'g<DOWN>'},

  -- space clears search highlights and messages
  {'n', '<Space>', ':nohlsearch<Bar>:echo <CR>l' },

  -- H and L works as 0 and $
  {{'n', 'v'}, 'H', '0'},
  {{'n', 'v'}, 'L', '$'},

  -- spelling
  {'n', '<leader>l', ':setlocal spell!<CR>'},

  -- toggle invisible characters
  {'n', '<leader>c', ':set list!<CR>'},

  -- better scrolling with j/k instead of e/y
  {'n', '<C-J>', '<C-E>'},
  {'n', '<C-K>', '<C-Y>'},

  -- indent whole file
  {'n', '<leader>=', 'gg=G<C-O>'},

  -- move between buffers
  {'n', '<Tab><Tab>', ':bnext<CR>'},
  {'n', '<S-Tab><S-Tab>', ':bprev<CR>'},
  {'n', '<leader>bb', ':b#<CR>'}, -- goto last buffer
  {'n', '<C-\\><C-\\>', ':b#<CR>'}, -- goto last buffer
  {'n', '<leader>bd', ':bdelete<CR>'},
  {'n', '<C-\\>q', ':bdelete<CR>'},

  -- base64 encode/decode
  {'v', '<leader>e64', [[c<C-R>=system('base64 -w 0', @")<CR><ESC>]]},
  {'v', '<leader>d64', [[c<C-R>=system('base64 -w 0 --decode', @")<CR><ESC>]]},

  -- global copy/paste
  {{'n', 'v'}, '<leader>y', '"+y'},
  {{'n', 'v'}, '<leader>Y', '"+Y'},
  {'n', '<leader>p', '"+p'},
  {'n', '<leader>P', '"+P'},

  -- restore normal Y behavior. (https://github.com/neovim/neovim/pull/13268)
  {'n', 'Y', 'yy'},

  -- visual indent/unindent block
  {'v', '>', '>gv'},
  {'v', '<', '<gv'},
}

local keybind = require('utils').keybind

for _, mapping in pairs(mappings) do
  keybind(mapping)
end

-- Search for visually selected text, forwards or backwards.
-- TODO: Port this to lua
vim.cmd([[
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gVzv:call setreg('"', old_reg, old_regtype)<CR>
]])
