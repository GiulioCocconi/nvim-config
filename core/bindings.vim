let mapleader = " " " Set leader to SPC

map <leader>cr :call LoadAllConfig()<CR>| "Reloads config files
map <leader>ce :execute ":Explore " . g:core_config_dir<CR>| "Opens the config dir in Explore
map <leader>cd :call CdCurrentBufferDir()<CR>
map <leader>sr :recover<CR>| " Recovers the swap file
map <leader>sd :call DeleteCurrentFileSwap()<CR>
map <leader><esc> :nohlsearch<CR>| "Clears search highlight

map <leader>bk :bwipeout<CR>
map <leader>bl :buffers<CR>
map <leader>bn :bnext<CR>

map <leader>wv :vsplit<CR>
map <leader>wh :split<CR>
map <leader>ww <C-w>w| "Makes you go to the next windows

map <leader>qa :qall<CR>
map <leader>wa :wall<CR>
