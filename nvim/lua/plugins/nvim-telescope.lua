return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = {
		'nvim-lua/plenary.nvim' 
	},
	config = function()
		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>gi', builtin.lsp_incoming_calls, {})
		vim.keymap.set('n', '<leader>go', builtin.lsp_outgoing_calls, {})
		vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
		vim.keymap.set('n', '<leader>gI', builtin.lsp_implementations, {})
		vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
		vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, {})

		require('telescope').setup{
			defaults = {
				i = {
				},
			},
		}

	end
}


