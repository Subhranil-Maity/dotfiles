return {
	'numToStr/Navigator.nvim',
	config = function()
		require('Navigator').setup()
		vim.keymap.set({ 'n', 'i' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
		vim.keymap.set({ 'n', 'i' }, '<C-l>', '<CMD>NavigatorRight<CR>')
		vim.keymap.set({ 'n', 'i' }, '<C-k>', '<CMD>NavigatorUp<CR>')
		vim.keymap.set({ 'n', 'i' }, '<C-j>', '<CMD>NavigatorDown<CR>')
		vim.keymap.set({ 'n', 'i' }, '<C-p>', '<CMD>NavigatorPrevious<CR>')
	end,
}
