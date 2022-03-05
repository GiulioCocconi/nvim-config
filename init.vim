let g:core_config_dir = stdpath('config') . "/core"
let s:core_files = ['bindings.vim', 'plugins.vim', 'core.vim']

let s:install_unix_script = stdpath('config') . '/install.sh'
let s:install_check = stdpath('config') . '/.installed'

let s:debug_file = stdpath('config') . '/.debug'

"Debug
function CheckDebug()
	let g:init_debug = !empty(glob(s:debug_file))
endfunction

function ToggleDebug()
	if g:init_debug
		echom "Debug deactivated"
		silent! execute "!rm " . s:debug_file
	else
		echom "Debug activated"
		silent! execute "!touch " . s:debug_file
	endif
	call CheckDebug()
endfunction

command Td :call ToggleDebug()

function Debug(msg)
	if g:init_debug == 1
		echom "[Debug] " . a:msg
	endif
endfunction


"Load Config
function LoadConfigFile(fname)
	let l:fpath = g:core_config_dir . '/' . a:fname
	silent! execute printf("source %s", l:fpath)
	call Debug(a:fname . " Loaded")
endfunction

function LoadAllConfig()
	for l:fname in s:core_files
		call LoadConfigFile(l:fname)
	endfor
	echom "Configuration files loaded!"
endfunction

function LoadFirstTime()
	call LoadConfigFile("plugins.vim")
	PlugInstall
	call LoadAllConfig()
endfunction


"Install script
function RunInstallScript()
	if !has('unix')
		echom "Your OS is not supported :(" "For now...
		return 0
	endif

	if !has('nvim')
		echom "Please use nvim!"
		return 0
	endif

	echom "I'm running the setup script..."
	execute printf('!bash %s %s %s %s', s:install_unix_script, stdpath('config'), stdpath('data'), s:install_check)
endfunction


" Entry Point
call CheckDebug()
call Debug("Checking for the presence of " . s:install_check)
if !empty(glob(s:install_check))
	call Debug(s:install_check . " found")
	call LoadAllConfig()
else
	call Debug(s:install_check . " not found")
	call RunInstallScript()


	if !empty(glob(s:install_check))
		call LoadFirstTime()
	endif
endif

