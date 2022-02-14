let s:core_files = ['plugins.vim', 'core.vim']
let s:install_unix_script = 'install.sh'

function LoadVimFile(fname)
	let l:fpath = stdpath('config') . '/' . a:fname
	execute printf("source %s", l:fpath)
endfunction

function LoadAllConfig()
	for l:fname in s:core_files
		call LoadVimFile(l:fname)
		"echo printf("%s loaded", l:fname) 
	endfor	
	echom "Configuration files loaded!"
endfunction

function RunInstallScript()
	if has('unix')
		echom "I'm running the setup script..."
		execute printf('!bash %s %s %s', s:install_unix_script, stdpath('config'), stdpath('data'))
		return 1
	else
		echom "Your OS is not supported :("
		return 0
	endif
endfunction

function ReloadConfig()
	let l:init_path = stdpath('config') . "/init.vim"
	silent! execute printf("source %s", l:init_path)
	call LoadAllConfig()
	PlugInstall
endfunction

" Entry Point

if !empty(glob(stdpath('config') . "/.installed"))
	call LoadAllConfig()
else
	if RunInstallScript() == 1
		call ReloadConfig()
	endif
endif

