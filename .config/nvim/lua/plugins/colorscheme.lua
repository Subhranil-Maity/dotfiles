colorConfig = function()
	function ColorMyPencils(color)
		color = color or "catppuccin"
		vim.cmd("colorscheme " .. color)

		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end

	ColorMyPencils()
end

--return { 'rose-pine/neovim', name = 'rose-pine', config = colorConfig }
return {

	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = colorConfig
	}
}
