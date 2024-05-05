telescopeConfig = function()
	require('telescope').setup {
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown(),
			},
		},
	}
	pcall(require('telescope').load_extension, 'fzf')
	pcall(require('telescope').load_extension, 'ui-select')
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
	-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
	vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
	vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
	-- vim.keymap.set('n', '<leader>fs', function()
	-- 	builtin.grep_string({search = vim.fn.input("Grep > ")})
	-- end)

	vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 10,
			previewer = false,
		})
	end, { desc = '[/] Fuzzily search in current buffer' })
end
return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.3',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = "make",
			cond = function()
				return vim.fn.executable('make') == 1
			end,
		},
		{
			'nvim-tree/nvim-web-devicons',
			enabled = vim.g.have_nerd_fonts
		},

	},
	config = telescopeConfig
}
