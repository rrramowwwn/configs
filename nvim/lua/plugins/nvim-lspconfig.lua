return {
	'neovim/nvim-lspconfig',
	config = function()

		-- LSP
		local lspconfig = require('lspconfig')
		local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		--lspconfig.tsserver.setup{}

		-- npm i -g bash-language-server
		--require'lspconfig'.bashls.setup{}

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
					buildFlags = {
						"-tags=vddk",
					},
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						fieldalignment = true,
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
				}
			},
			-- NVIM-CMP + LSP
			capabilities = cmp_capabilities,
		})

		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function()
				local bufmap = function(mode, lhs, rhs)
					local opts = { buffer = true }
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				-- Displays hover information about the symbol under the cursor
				bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

				-- Jump to the definition
				bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

				-- Jump to declaration
				bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

				-- Lists all the implementations for the symbol under the cursor
				bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

				-- Jumps to the definition of the type symbol
				bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

				-- Lists all the references 
				bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

				-- Displays a function's signature information
				bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

				-- Renames all references to the symbol under the cursor
				bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

				-- Selects a code action available at the current cursor position
				bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

				-- Show diagnostics in a floating window
				bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

				-- Move to the previous diagnostic
				bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

				-- Move to the next diagnostic
				bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

			end
		})
	end
}

