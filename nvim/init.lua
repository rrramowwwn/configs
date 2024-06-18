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

require("lazy").setup("plugins")

-- General editor
vim.o.number = true
vim.o.relativenumber = true
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
vim.o.cmdheight = 0
vim.o.cursorline = true

