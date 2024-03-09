local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.UI.colorscheme"),

	require("plugins.UI.neotree"),
	require("plugins.UI.lualine"),
	require("plugins.UI.bufferline"),
	require("plugins.UI.edgy"),
	require("plugins.UI.indentscope"),
	require("plugins.UI.dressing"),
	require("plugins.UI.noice"),
	require("plugins.UI.notify"),
	require("plugins.UI.incline"),

	require("plugins.edit.autopairs"),
	require("plugins.edit.comment"),
	require("plugins.edit.surround"),
	require("plugins.edit.bufremove"),
	require("plugins.edit.trouble"),
	require("plugins.edit.gitsigns"),
	require("plugins.edit.files"),
	require("plugins.edit.spectre"),

	require("plugins.tools.telescope"),
	require("plugins.tools.toggleterm"),
	require("plugins.tools.whichkey"),
	require("plugins.tools.flash"),
	require("plugins.tools.dashboard"),
	require("plugins.tools.persistence"),
	require("plugins.tools.lazygit"),

	require("plugins.lsp.lspconfig"),
	require("plugins.lsp.illuminate"),
	require("plugins.lsp.mason"),
	require("plugins.lsp.cmp"),
	require("plugins.lsp.treesitter"),
	require("plugins.lsp.symbols-outline"),

	require("plugins.lsp.lang.clangd"),
})
