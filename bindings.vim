let mapleader = " " " Set leader to SPC
set showcmd

map <leader>rc :call ReloadConfig(0)<CR>

map <leader>wv :vsplit<CR>
map <leader>wh :split<CR>
map <leader>ww <C-w>w

map <leader>t :terminal<CR>

map <leader>qa :qall<CR>
map <leader>wa :wall<CR>

map <leader>ff :Files<CR>
map <leader>fb :Buffers<CR>
map <leader>fc :Colors<CR>
map <leader>ft :Tags<CR>
map <leader>fC :Commands<CR>
map <leader>fs :Snippets<CR>

map <leader>z :DevDocsUnderCursor<CR>
