LspConfig = function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "clangd", "pylsp" },
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup {}
			end,
			-- ['rust_analyzer'] = {
			-- 	diagnostics = {
			-- 		enable = false,
			-- 	}
			-- },
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							}
						}
					}
				}
			end,
		}
	})
	local cmp = require('cmp')
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	cmp.setup({
		snippet = {
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
			['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
			['<C-m>'] = cmp.mapping.confirm({ select = true }),
			["<C-y>"] = cmp.mapping.complete(),
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			-- { name = 'vsnip' }, -- For vsnip users.
			{ name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = true,
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

	},
	config = LspConfig,
}

-- lspConfig = function()
-- 	local lsp_zero = require('lsp-zero')
-- 	lsp_zero.on_attach(function(client, bufnr)
-- 		local opts = { buffer = bufnr, remap = false }
--
-- 		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
-- 		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
-- 		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
-- 		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
-- 		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
-- 		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
-- 		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
-- 		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
-- 		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
-- 		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- 	end)
-- 	require('mason').setup({})
-- 	require('mason-lspconfig').setup({
-- 		ensure_installed = { 'lua_ls' },
-- 		handlers = {
-- 			lsp_zero.default_setup,
-- 		},
-- 	})
-- 	local cmp = require('cmp')
-- 	local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- 	local cmp_mappings = lsp_zero.defaults.cmp_mappings({
-- 		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
-- 		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
-- 		['<C-m>'] = cmp.mapping.confirm({ select = true }),
-- 		["<C-y>"] = cmp.mapping.complete(),
-- 	})
-- 	cmp.setup({
-- 		sources = {
-- 			{ name = 'nvim_lsp' }
-- 		},
-- 		mapping = cmp_mappings,
-- 		snippet = {
-- 			expand = function(args)
-- 				require('luasnip').lsp_expand(args.body)
-- 			end,
-- 		},
-- 	})
-- 	local cmp_nvim_lsp = require "cmp_nvim_lsp"
--
-- require("lspconfig").clangd.setup {
--   on_attach = on_attach,
--   capabilities = cmp_nvim_lsp.default_capabilities(),
--   cmd = {
--     "clangd",
--     "--offset-encoding=utf-16",
--   },
-- }
-- end
--
-- return {
-- 	--- Uncomment these if you want to manage LSP servers from neovim
-- 	{ 'williamboman/mason.nvim' },
-- 	{ 'williamboman/mason-lspconfig.nvim' },
--
-- 	-- LSP Support
-- 	{
-- 		'neovim/nvim-lspconfig',
-- 		dependencies = {
-- 			{ 'hrsh7th/cmp-nvim-lsp' },
-- 		},
-- 	},
--
-- 	-- Autocompletion
-- 	{
-- 		'hrsh7th/nvim-cmp',
-- 		dependencies = {
-- 			{ 'L3MON4D3/LuaSnip' },
-- 		}
-- 	}
-- }
