return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({})
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end
	}
}
