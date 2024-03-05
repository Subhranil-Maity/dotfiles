colorConfig = function()
	require('rose-pine').setup({
		disable_background = true
	})

	function ColorMyPencils(color)
		color = color or "catppuccin"
		vim.cmd("colorscheme " .. color)
	end

	ColorMyPencils()
end

--return { 'rose-pine/neovim', name = 'rose-pine', config = colorConfig }
return {
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		config = colorConfig
	},
	{ "catppuccin/nvim", as = "catppuccin" }
}
