function! s:Move(cmd, count, map) abort
  normal! m`
  silent! exe 'move'.a:cmd.a:count
  norm! ``
  silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  normal! m`
  silent! exe "'<,'>move'<--".a:count
  norm! ``
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
endfunction
function! s:MoveSelectionDown(count) abort

  normal! m`
  norm! ``
  exe "'<,'>move'>+".a:count
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveSelectionUp
xmap ]e <Plug>unimpairedMoveSelectionDown
