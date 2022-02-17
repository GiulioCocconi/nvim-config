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

colorscheme minimalist


function CurrentFileParentDir(level)
	let l:fpath = split(expand('%:p'), "/")
	let l:until = -2 - a:level
	return "/" . join(l:fpath[0:l:until], "/") . "/"

endfunction
