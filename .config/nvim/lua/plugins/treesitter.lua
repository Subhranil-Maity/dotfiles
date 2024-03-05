treesitterConfig = function()
	require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "python" },

  sync_install = false,

  auto_install = true,


  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}
end
return {
	"nvim-treesitter/nvim-treesitter",
    	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			init = function()
				-- disable rtp plugin, as we only need its queries for mini.ai
				-- In case other textobject modules are enabled, we will load them
				-- once nvim-treesitter is loaded
				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				load_textobjects = true
			end,
		},
	},
	cmd = { "TSUpdateSync" },
	config = treesitterConfig
}
