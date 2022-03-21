
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

