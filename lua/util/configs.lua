local M = {
	path = vim.fn.stdpath("config"),
	colorscheme = "catppuccin",
	tabs = {
		expanded = false,
		width = 4,
	},
	cursors = {
		line = true,
		column = false,
		scrolloff = 6,
		scrolloff_bkup = 0,
	},
	LazyFile = { "BufReadPost", "BufWritePost", "BufNewFile" },

	toggle_opt = function(opt, a, b)
		if opt == a then
			return b
		else
			return a
		end
	end
}

return M
