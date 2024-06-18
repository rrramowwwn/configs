return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local overseer = require('overseer')

		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'gruvbox',
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename', 'bo:filetype'},
				lualine_x = { 
					'overseer',
				},
				lualine_y = { 'encoding', 'fileformat', 'filetype' },
				lualine_z = { 'progress', 'location' },
			},
			extensions = {
				'quickfix',
				'fugitive',
				'lazy',
				'neo-tree',
			}
		}

	end
}


