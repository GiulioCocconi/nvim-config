let g:core_config_dir = stdpath('config') . "/core"
let s:scripts_dir = stdpath('config') . "/scripts"
let s:plugin_config_dir = stdpath('config') . "/plugins"

let g:core_files = ['core.vim', 'bindings.vim', 'plugins.vim']

let s:update_script = s:scripts_dir . '/update.sh'
let s:install_unix_script = s:scripts_dir . '/install.sh'

let s:install_check = stdpath('config') . '/.installed'

let s:install_args = printf("%s %s %s", stdpath('config'), s:scripts_dir, s:install_check)

let s:debug_file = stdpath('config') . '/.debug'

let s:last_update_check_file = stdpath('config') . '/.lastUpdateCheckTime'

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
	execute "source" . l:fpath
	call Debug(a:fname . " Loaded")
endfunction

function LoadPluginsConfig()
	for l:file in glob(s:plugin_config_dir . "/*.vim", 1, 1)
		call Debug(l:file . " plugin config loaded")
		execute "source " . l:file
	endfor
endfunction

function LoadAllConfig()
	for l:fname in g:core_files
		call LoadConfigFile(l:fname)
	endfor

	call LoadPluginsConfig()

	echom "Configuration files loaded!"

	call CheckUpdates(0)

endfunction

" Install functions

function CheckUpdateTimeCondition()

	if empty(glob(s:last_update_check_file))
		silent! execute "!touch " . s:last_update_check_file
		call writefile(["0"], s:last_update_check_file)
	endif

	if (!g:autoUpdate)
		return 0
	endif

	let l:local_t = localtime()
	let l:last_t = str2nr(readfile(s:last_update_check_file)[0])

	call Debug("Last update check in EPOCH " . l:last_t)

	let l:diff_t = l:local_t - l:last_t

	call Debug("EPOCH diff: " . l:diff_t)

	return l:diff_t >= 604800

endfunction

function CheckUpdates(isRequiredByUser)

	if (!(a:isRequiredByUser || CheckUpdateTimeCondition()))
		return
	endif

	if (a:isRequiredByUser)
		echom "Checking for updates..."
	else
		call Debug("Checking for updates...")
	endif

	call writefile([localtime()], s:last_update_check_file)

	let l:git_command = printf("git -C %s ", stdpath('config'))

	silent! call system(l:git_command . "fetch")

	let l:local_rev = system(l:git_command . "rev-parse @")
	let l:remote_rev = system(l:git_command . "rev-parse '@{u}'")
	let l:base = system(l:git_command . "merge-base @ '@{u}'")

	let l:hasUpdate = l:local_rev != l:remote_rev && l:local_rev == l:base

	if (l:hasUpdate)

		if (confirm("Update found. Install it?", "&Yes\n&No") - 1)
			echom "I'm not installing it"
			return
		endif

		echom "Installing update..."

		execute printf('!bash %s %s', s:update_script, s:install_args)
		PlugClean! | PlugUpdate | UpdateRemotePlugins
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
	call Debug("Loading the config for the first time...")
	call LoadConfigFile("plugins.vim")
	PlugInstall | UpdateRemotePlugins
	call LoadAllConfig()
	call QuitAfterInstall()
endfunction


function QuitAfterInstall()
	echom "Install finished, quitting vim..."
	if empty(glob(s:debug_file))
		sleep 2
		qall
	endif
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

	if !has('nvim-0.6.0')
		echom "Please use nvim >= 0.6.0"
		return
	endif

	echom "I'm running the setup script..."
	execute printf('!bash %s %s', s:install_unix_script, s:install_args)

	if !empty(glob(s:install_check))
		call LoadFirstTime()
	endif
endfunction


" Entry Point
runtime! plugin/rplugin.vim
call Debug("Checking for the presence of " . s:install_check)

if !empty(glob(s:install_check))
	call Debug(s:install_check . " found")
	call LoadAllConfig()

else
	call Debug(s:install_check . " not found")
	call InstallConfig()
endif
