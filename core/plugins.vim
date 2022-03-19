augroup reload_plug_config
	autocmd!
	autocmd BufWritePost plugins.vim source <afile> | PlugInstall
augroup end

function! UpdateRemotePlugins(...)
	" Needed to refresh runtime files
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction


call plug#begin(stdpath('data') . '/plugins')
call Debug("Plug begin")

Plug 'nathom/filetype.nvim' "Faster load time
Plug 'nvim-treesitter/nvim-treesitter',  {'do': ':TSUpdate'} "Better highlighting
Plug 'nvim-lua/plenary.nvim' "Dep for a lot of plugins
Plug 'karb94/neoscroll.nvim' "Smoother scroll
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') } "Completion in the wild menu
Plug 'lambdalisue/suda.vim' "Write files using `sudo`

"Ide-like functionality
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Completion framework
Plug 'godlygeek/tabular' "Line up text 
Plug 'majutsushi/tagbar' "Tags manager
Plug 'jiangmiao/auto-pairs' 
Plug 'numToStr/Comment.nvim' "Comment more line of code with one keystroke
Plug 'voldikss/vim-floaterm' "Floating term and windows manager
Plug 'embear/vim-localvimrc' "Load local config in working directory
Plug 'kyazdani42/nvim-tree.lua' "Tree of project files
Plug 'mg979/vim-visual-multi' "Multicursor
Plug 'rhysd/devdocs.vim'

"Greeter
Plug 'glepnir/dashboard-nvim'

""fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/calendar.vim'

"Theme
"Plug 'dikiaap/minimalist'
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'

""Rust
Plug 'rust-lang/rust.vim'

Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call Debug("Plug end")
call plug#end()


"Theme's config
colorscheme rigel
let g:airline_theme='rigel'
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

"Dashboard's config
let g:dashboard_default_executive ='fzf'
let g:dashboard_custom_header = [
			\'',
			\'  ██████╗       ██████╗     █╗  ███████╗     ███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗ ',
			\' ██╔════╝      ██╔════╝     ╚╝  ██╔════╝     ████╗  ██║ ██║   ██║ ██║ ████╗ ████║ ',
			\' ██║  ███╗     ██║              ███████╗     ██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║ ',
			\' ██║   ██║     ██║              ╚════██║     ██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ',
			\' ╚██████╔╝ ██╗ ╚██████╗ ██╗     ███████║     ██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ',
			\'  ╚═════╝  ╚═╝  ╚═════╝ ╚═╝     ╚══════╝     ╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ',
			\] 

map <Leader>ss :<C-u>SessionSave<CR>
map <Leader>sl :<C-u>SessionLoad<CR>



map <silent> <Leader>fh :DashboardFindHistory<CR>
map <silent> <Leader>ff :DashboardFindFile<CR>
map <silent> <Leader>tc :DashboardChangeColorscheme<CR>
map <silent> <Leader>fa :DashboardFindWord<CR>
map <silent> <Leader>fb :DashboardJumpMark<CR>
map <silent> <Leader>cn :DashboardNewFile<CR>

"Wilder's config
call wilder#setup({'modes': [':', '/', '?']})

"Tree's config
lua require'nvim-tree'.setup()
map <leader>t :NvimTreeToggle<CR>

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
