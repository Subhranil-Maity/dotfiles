nvimtreeConfig = function()
	-- disable netrw at the very start of your init.lua
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- set termguicolors to enable highlight groups
	vim.opt.termguicolors = true

	-- empty setup using defaults
	require("nvim-tree").setup()
	--vim.kaymap.set('i', '<C-e>', ":NvimTreeToggle <CR>")
end
return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {{'nvim-tree/nvim-web-devicons'}},
	config = nvimtreeConfig
}
