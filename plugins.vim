augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.vim source <afile> | PlugInstall
augroup end

call plug#begin(stdpath('data') . '/plugins')

Plug 'jiangmiao/auto-pairs'

"Greeter
Plug 'mhinz/vim-startify'

"Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()


