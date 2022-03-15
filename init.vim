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

	call CheckUpdates(0)

endfunction

" Install functions

function CheckUpdates(isRequiredByUser)
	if (!(g:autoUpdate || a:isRequiredByUser))
		return
	endif

	if (a:isRequiredByUser)
		echom "Checking for updates"
	else
		call Debug("Checking for updates...")
	endif


	let l:git_command = printf("git -C %s ", stdpath('config'))

	silent! call system(l:git_command . "fetch")

	let l:local_rev = system(l:git_command . "rev-parse @") 
	let l:remote_rev = system(l:git_command . "rev-parse '@{u}'")
	let l:base = system(l:git_command . "merge-base @ '@{u}'")

	let l:hasUpdate = l:local_rev != l:remote_rev && l:local_rev == l:base

	if (l:hasUpdate)

		if (confirm("Update found. Install it?", "&Yes\n&No"))
			echom "I'm not installing it"
			return
		endif

		echom "Installing update..."
		execute printf('!bash %s %s', s:update_script, s:install_args)
		call QuitAfterInstall()
	else
		if (a:isRequiredByUser)
			echom "Nvim is already updated"
		else
			call Debug("Nvim is already updated")
		endif
	endif
endfunction

command UpdateConfig call CheckUpdates(1) 


function LoadFirstTime()
	call LoadConfigFile("plugins.vim")
	PlugInstall
	call LoadAllConfig()
	call QuitAfterInstall()
endfunction


function QuitAfterInstall()
	echom "Install finished, quitting vim..."
	sleep 1
	qall
endfunction

function InstallConfig()
	if !has('unix')
		echom "Your OS is not supported :(" "For now...
		return
	endif

	if !has('nvim')
		echom "Please use nvim!"
		return
	endif

	echom "I'm running the setup script..."
	execute printf('!bash %s %s', s:install_unix_script, s:install_args)

	if !empty(glob(s:install_check))
		call Debug("Loading the config for the first time...")
		call LoadFirstTime()
	endif
endfunction


" Entry Point
call Debug("Checking for the presence of " . s:install_check)

if !empty(glob(s:install_check))
	call Debug(s:install_check . " found")
	call LoadAllConfig()

else
	call Debug(s:install_check . " not found")
	call InstallConfig()
endif

