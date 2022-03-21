function FindFileInCurrentDir()
	let l:current_fdir = CurrentFileParentDir(0)
	call Debug("Dir is " . l:current_fdir)
	execute ':Files ' . l:current_fdir
endfunction

function FindFileInParentDir()
	let l:current_fdir = CurrentFileParentDir(0)
	call inputsave()
	let l:level = input(printf("Subdir level to search in (%s): ", l:current_fdir))
	call inputrestore()

	let l:search_dir = CurrentFileParentDir(l:level)

	execute ':Files ' . l:search_dir
endfunction

function FindFileInput()
	call inputsave()
	let l:fdir = input("Search in dir: ")
	call inputrestore()
	execute ':Files ' . l:fdir
endfunction

map <leader>fz :call FindFileInCurrentDir()<CR>
map <leader>fZ :Files<CR>| "FZF fuzzy find
map <leader>fb :Buffers<CR>| "FZF find buffers
map <leader>ft :Tags<CR>| "FZF find tags
map <leader>fC :Commands<CR>| "FZF find commands
