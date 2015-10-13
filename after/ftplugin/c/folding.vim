function! CFolds()
	let line=getline(v:lnum)
	if match(line, "{$") >= 0

		return ">1"

	elseif

	endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=CFolds()
