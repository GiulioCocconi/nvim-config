augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.vim source <afile> | PlugInstall
augroup end

call plug#begin(stdpath('data') . '/plugins')
call Debug("Plug begin")
"Ide-like functionality

Plug 'vim-syntastic/syntastic'
Plug 'jayli/vim-easycomplete'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'

"Greeter
Plug 'mhinz/vim-startify'

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Theme
Plug 'dikiaap/minimalist'
Plug 'vim-airline/vim-airline'

Plug 'rhysd/devdocs.vim'

call Debug("Plug end")
call plug#end()

"Snippets and compl
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Theme's config
let g:airline_theme='minimalist'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

"FZF's config
function FindFileInDirectory() 
	let l:fpath = split(@%, "/");
	return join(l:fpath[0:-2], "/")
endfunction

