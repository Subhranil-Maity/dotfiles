navCOnfig = function() 
		-- Set g:tmux_navigator_no_mappings to 1
-- vim.g.tmux_navigator_no_mappings = 1

-- Define the key mappings
vim.api.nvim_set_keymap('n', 'C-h', ':TmuxNavigateLeft<cr>', {})
vim.api.nvim_set_keymap('n', 'C-j', ':TmuxNavigateDown<cr>', {})
vim.api.nvim_set_keymap('n', 'C-k', ':TmuxNavigateUp<cr>', {})
vim.api.nvim_set_keymap('n', 'C-l', ':TmuxNavigateRight<cr>', {})
-- vim.api.nvim_set_keymap('n', '<silent> {Previous-Mapping}', ':<C-U>TmuxNavigatePrevious<cr>', {})

end
return {
		'christoomey/vim-tmux-navigator',
		lazy = flase
}
