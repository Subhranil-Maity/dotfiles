vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.swapfile = true
vim.opt.backup = false


vim.opt.smartindent = true


vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.signcolumn = 'yes'




vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "",
	callback = function ()
		vim.highlight.on_yank()
	end
})
