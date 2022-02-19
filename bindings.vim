let mapleader = " " " Set leader to SPC
set showcmd

map <leader>rc :call ReloadConfig(0)<CR>
map <leader>sr :recover<CR>
map <leader>sd :call DeleteCurrentFileSwap()<CR>
map <leader><esc> :let @/ = ""<CR>

map <leader>bk :bwipeout<CR>
map <leader>bl :buffers<CR>
map <leader>bn :bnext<CR>

map <leader>wv :vsplit<CR>
map <leader>wh :split<CR>
map <leader>ww <C-w>w

map <leader>qa :qall<CR>
map <leader>wa :wall<CR>
