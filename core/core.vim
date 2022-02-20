set nocompatible
set showmatch
set ignorecase
set hlsearch

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set autoindent
set clipboard+=unnamedplus
set number

" In insertmode i numeri sono normali, in normalmode relativi
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

syntax on

if (has("termguicolors"))
	set termguicolors
else
	set t_Co=256
endif

function CurrentFileParentDir(level)
	let l:fpath = split(expand('%:p'), "/")
	let l:until = -2 - a:level
	return "/" . join(l:fpath[0:l:until], "/") . "/"
endfunction

function CurrentFileSwap()
	let l:fdir = expand('%:p')
	let l:chunk = substitute(l:fdir, "/", "%", "g") . ".swp"
	return "~/.local/share/nvim/swap//" . l:chunk
endfunction

function DeleteCurrentFileSwap()
	let l:swapfile = CurrentFileSwap()
	if !filereadable(expand(l:swapfile))
		echom "This document hasn't got any swapfile"
		return
	endif

	let l:choice = confirm(printf("Do you really want to delete %s? ", l:swapfile), "&No\n&yes")

	if choice == 0
		echo "Swap file not removed"
		return
	endif

	silent! execute "!rm " . escape(l:swapfile, "%")
	echo "Swap file removed"
endfunction
