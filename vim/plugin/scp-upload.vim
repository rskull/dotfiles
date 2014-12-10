" Header.
" --------------------
" scp-upload.vim
" Maintainer:   https://github.com/ryoppy/vim-scp-upload
" Version:      1.0

" Command.
" --------------------
map <silent>scp <ESC>:call ScpUpload()<CR>

" Logic.
" --------------------
function! ScpUpload()

	if !exists("g:vim_scp_configs")
		echo '設定がありません。'
		return
	endif

	let configs = g:vim_scp_configs
	let self_path = expand("%:p")

	for key in keys(configs)
        let config = configs[key]
		let local_base_path = config['local_base_path']
		if self_path =~ "^" . local_base_path
			let target_config        = config
			let target_project       = key
			let target_relative_path = self_path[strlen(local_base_path):]
            echo key
            let check = confirm('このプロジェクトでいい？', "&Yes\n&No", 2)
            if check != 2
                break
            endif
        endif
	endfor

    if check == 2
        return
    endif

	if !exists("target_project")
		echo '対象が見つかりません。'
        return
	endif

	let local_full_path  = target_config['local_base_path']  . target_relative_path
	let remote_full_path = target_config['remote_base_path'] . target_relative_path

	if self_path != local_full_path
	    echo 'パスがおかしいよ'
    endif

	echo "local_full_path : " . local_full_path
	echo "remote_full_path : " . remote_full_path

	let tc = target_config
	let cmd = printf('sh ~/.vim/bin/scp.sh %s %s %s %s %s %s', tc['host'], tc['user'], tc['pass'], tc['port'], local_full_path, remote_full_path)
	echo cmd

	let choice = confirm('アップしますよ？', "&Yes\n&No", 2)
	if choice != 1
		echo 'キャンセルしました。'
		return
	endif

	execute '!' . cmd

endfunction
