augroup reload_plug_config
	autocmd!
	autocmd BufWritePost plugins.vim source <afile> | PlugInstall | call LoadPluginsConfig() 
augroup end

call plug#begin(stdpath('data') . '/plugins')
call Debug("Plug begin")

Plug 'nathom/filetype.nvim' "Faster load time
Plug 'nvim-lua/plenary.nvim' "Dep for a lot of plugins
Plug 'karb94/neoscroll.nvim' "Smoother scroll
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'gelguy/wilder.nvim'
Plug 'lambdalisue/suda.vim' "Write files using `sudo`

"Completion framework
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

Plug 'godlygeek/tabular' "Line up text 
Plug 'majutsushi/tagbar' "Tags manager
Plug 'jiangmiao/auto-pairs' 
Plug 'numToStr/Comment.nvim' "Comment more line of code with one keystroke
Plug 'voldikss/vim-floaterm' "Floating term and windows manager
Plug 'embear/vim-localvimrc' "Load local config in working directory
Plug 'kyazdani42/nvim-tree.lua' "Tree of project files
Plug 'mg979/vim-visual-multi' "Multicursor
Plug 'rhysd/devdocs.vim'
Plug 'folke/todo-comments.nvim'

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
Plug 'rust-lang/rust.vim', { 'for': ['rust', 'vim-plug'] }

Plug 'preservim/vim-markdown', { 'for': ['markdown', 'vim-plug'] }

call Debug("Plug end")
call plug#end()
