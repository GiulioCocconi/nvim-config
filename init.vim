let g:core_config_dir = stdpath('config') . "/core"
let s:scripts_dir = stdpath('config') . "/scripts"

let g:core_files = ['bindings.vim', 'plugins.vim', 'core.vim']

let s:update_script = s:scripts_dir . '/update.sh'
let s:install_unix_script = s:scripts_dir . '/install.sh'

let s:install_check = stdpath('config') . '/.installed'

let s:install_args = printf("%s %s %s", stdpath('config'), s:scripts_dir, s:install_check)

let s:debug_file = stdpath('config') . '/.debug'

"Debug
function ToggleDebug()
	if !empty(glob(s:debug_file))
		echom "Debug deactivated"
		silent! execute "!rm " . s:debug_file
	else
		echom "Debug activated"
		silent! execute "!touch " . s:debug_file
	endif
endfunction

command Td :call ToggleDebug()

function Debug(msg)
	if !empty(glob(s:debug_file))
		echom "[Debug] " . a:msg
	endif
endfunction

function CheckUpdates()
	call Debug("Checking for updates...")
	
	let l:git_command = printf("git -C %s rev-parse", stdpath('config'))

	let l:local_rev = system(l:git_command . " HEAD") 
	let l:remote_rev = system(l:git_command . " $(git branch -r --sort=committerdate | tail -1)")

	let l:hasUpdate = l:local_rev != l:remote_rev

	if (l:hasUpdate)
		call Debug("Update found")
	else
		call Debug("Nvim is already updated")
	endif

	return l:hasUpdate

endfunction

"Load Config
function LoadConfigFile(fname)
	let l:fpath = g:core_config_dir . '/' . a:fname
	silent! execute printf("source %s", l:fpath)
	call Debug(a:fname . " Loaded")
endfunction

function LoadAllConfig()
	for l:fname in g:core_files
		call LoadConfigFile(l:fname)
	endfor
	echom "Configuration files loaded!"

	if (g:autoUpdate && CheckUpdates())
		echom "Installing an update..."
		execute printf('!bash %s %s', s:update_script, s:install_args)
		call QuitAfterInstall()
	endif

endfunction

function LoadFirstTime()
	call LoadConfigFile("plugins.vim")
	PlugInstall
	call LoadAllConfig()
endfunction

function QuitAfterInstall()
		echom "Install finished, quitting vim..."
		sleep 1
		qall
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
	execute printf('!bash %s %s', s:install_unix_script, s:install_args)
endfunction


" Entry Point
call Debug("Checking for the presence of " . s:install_check)

if !empty(glob(s:install_check))
	call Debug(s:install_check . " found")

	call LoadAllConfig()

else
	call Debug(s:install_check . " not found")
	call RunInstallScript()

	if !empty(glob(s:install_check))
		call Debug("Loading the config for the first time...")
		call LoadFirstTime()
		call QuitAfterInstall()
	endif
endif

