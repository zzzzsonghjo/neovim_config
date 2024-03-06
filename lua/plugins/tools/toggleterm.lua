return {
	'akinsho/toggleterm.nvim',
	version = "*",
	event = "VeryLazy",
	config = true,
	keys = {
		{ "<leader>tt", "<Cmd>ToggleTerm direction=horizontal<Cr>", desc = "Open terminal" },
		{ "<leader>tf", "<Cmd>ToggleTerm direction=float<Cr>",      desc = "Open float terminal" },
		{ "<leader>ts", "<Cmd>TermSelect<Cr>",                      desc = "ToggleTerm select" },
	},
}
