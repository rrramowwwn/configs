return {
	name = "Build backup tool",
	builder = function()
		return {
			cmd = { 'go' },
			args = { 
				'build', 
				'-tags=vddk,cometprofile', 
				'-v', 
				--[[
				'-gcflags',
				'\"all=-N -l\"',
				]]--
				'-o',
				'backup-tool.exe'

			},

			name = "build-backup-tool",
			cwd = 'C:\\source\\comet\\gopath\\src\\backupapp\\backup-tool',
			env = {
				CC='x86_64-w64-mingw32-gcc',
				CXX='x86_64-w64-mingw32-g++',
				GO111MODULE='on',
				GOFLAGS='-mod=vendor',
				GOTRACEBACK='2',
				ZONEINFO='C:\\source\\comet\\vendor\\tzdata\\zoneinfo.zip',
				GOPATH='C:\\source\\comet\\gopath'
			},
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
