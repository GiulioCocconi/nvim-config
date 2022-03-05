augroup reload_plug_config
	autocmd!
	autocmd BufWritePost plugins.vim source <afile> | PlugInstall
augroup end

call plug#begin(stdpath('data') . '/plugins')
call Debug("Plug begin")

""Ide-like functionality
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion framework
Plug 'SirVer/ultisnips' "Snips framework
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar' "Tags manager
Plug 'jiangmiao/auto-pairs'
Plug 'voldikss/vim-floaterm' "Floating term and windows manager

"Greeter
Plug 'mhinz/vim-startify'

""fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""Theme
"Plug 'dikiaap/minimalist'
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'
Plug 'rhysd/devdocs.vim'

""Rust
Plug 'rust-lang/rust.vim'

Plug 'embear/vim-localvimrc'

call Debug("Plug end")
call plug#end()

"Snippets and compl
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Theme's config
colorscheme rigel
let g:airline_theme='rigel'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

"FZF's config
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

"Floaterm's Config
map <leader>ff :FloatermNew vifm<CR>| "Open vifm in floaterm
map <leader>' :FloatermToggle<CR>

"DevDocs' Config
map <leader>z :DevDocsUnderCursor<CR>