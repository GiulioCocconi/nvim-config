augroup reload_plug_config
	autocmd!
	autocmd BufWritePost plugins.vim source <afile> | PlugInstall
augroup end

call plug#begin(stdpath('data') . '/plugins')
call Debug("Plug begin")

Plug 'nathom/filetype.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

""Ide-like functionality
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion framework
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar' "Tags manager
Plug 'jiangmiao/auto-pairs'
Plug 'numToStr/Comment.nvim'
Plug 'voldikss/vim-floaterm' "Floating term and windows manager
Plug 'embear/vim-localvimrc'

"Greeter
"Plug 'mhinz/vim-startify'
Plug 'glepnir/dashboard-nvim'

""fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/calendar.vim'

"Theme
"Plug 'dikiaap/minimalist'
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'

Plug 'rhysd/devdocs.vim'

""Rust
Plug 'rust-lang/rust.vim'


call Debug("Plug end")
call plug#end()

"Theme's config
colorscheme rigel
let g:airline_theme='rigel'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

"Dashboard's config
let g:dashboard_default_executive ='fzf'
map <Leader>ss :<C-u>SessionSave<CR>
map <Leader>sl :<C-u>SessionLoad<CR>

map <silent> <Leader>fh :DashboardFindHistory<CR>
map <silent> <Leader>ff :DashboardFindFile<CR>
map <silent> <Leader>tc :DashboardChangeColorscheme<CR>
map <silent> <Leader>fa :DashboardFindWord<CR>
map <silent> <Leader>fb :DashboardJumpMark<CR>
map <silent> <Leader>cn :DashboardNewFile<CR>

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
"map <leader>ff :FloatermNew vifm<CR>| "Open vifm in floaterm
map <leader>' :FloatermToggle<CR>

"Comment.vim config
lua require('Comment').setup()

"DevDocs' Config
map <leader>z :DevDocsUnderCursor<CR>
