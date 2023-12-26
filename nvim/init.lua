-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = { ':TSUpdate' }
	},
	{
		'nvim-lualine/lualine.nvim'
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	{
		'neovim/nvim-lspconfig',
	},
	{
		'neoclide/coc.nvim',
		branch = 'release',
	},
})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup{
	defaults = {
		i = {
		},
	},
}

-- Neotree
require('neo-tree').setup({
	close_if_last_window = true,
	enable_git_status = true,
})
vim.keymap.set('n', '<C-d>', '<Cmd>Neotree toggle<CR>', {silent=true})

-- COC
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', {silent=true})
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', {silent=true})
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', {silent=true})
vim.keymap.set('n', 'K', 'CocActionAsync("doHover")', {silent=true})
vim.keymap.set('n', '<C-space>', 'coc#refresh()', {silent=true})
--
-- Use <c-j> to trigger snippets
local keyset = vim.keymap.set
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- LSP
local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
	cmd = {
		"gopls",
	},
	filetypes = {
		"go",
		"gomod",
		"gowork",
		"gotmpl",
	},
	rootdir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
	single_file_support = {
		true
	},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,

		}
	},
})

-- General editor
vim.o.number = true
vim.o.relativenumber = true
