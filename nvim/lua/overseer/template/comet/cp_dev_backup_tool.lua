return {
	name = "Copy backup-tool to dev",
	builder = function()
		return {
			cmd = { 'cp' },
			args = { 
				'backup-tool.exe', 
				'C:\\source\\comet\\build\\comet-win32-installer\\install_data_win64modern'

			},

			name = "copy-dev-backup-tool",
			cwd = 'C:\\source\\comet\\gopath\\src\\backupapp\\backup-tool',
			components = {
				{ "on_output_quickfix", open = true },
				"default",
			},
		}
	end,

	condition = {
		dir = "C:\\source\\comet\\gopath\\src\\backupapp"
	}
}
