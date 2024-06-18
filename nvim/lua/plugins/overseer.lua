return {
	"stevearc/overseer.nvim",
	opts = {},
	config = function()
		local overseer = require("overseer")

		overseer.setup({})
		overseer.load_template("comet.build_backup_tool")
		overseer.load_template("comet.cp_dev_backup_tool")
		overseer.load_template("comet.gotest")

		vim.keymap.set('n', '<C-s>', '<Cmd>OverseerToggle<CR>', {silent=true})
	end
}
