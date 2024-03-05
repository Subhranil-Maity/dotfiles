lspConfig = function()
	local lsp_zero = require('lsp-zero')
	lsp_zero.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end)
	require('mason').setup({})
	require('mason-lspconfig').setup({
		ensure_installed = { 'lua_ls' },
		handlers = {
			lsp_zero.default_setup,
		},
	})
	local cmp = require('cmp')
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_mappings = lsp_zero.defaults.cmp_mappings({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-Space>'] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.complete(),
	})
	cmp.setup({
		sources = {
			{ name = 'nvim_lsp' }
		},
		mapping = cmp_mappings,
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
	})
end

return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		config = lspConfig,
	},

	--- Uncomment these if you want to manage LSP servers from neovim
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },

	-- LSP Support
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
		},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' },
		}
	}
}
