local opt = vim.opt
local cfg = require("util.configs")

-- line number
opt.number = true
opt.relativenumber = true

-- clipboard
opt.clipboard = "unnamedplus"

-- tab
opt.shiftwidth = cfg.tabs.width
opt.tabstop = cfg.tabs.width
opt.expandtab = cfg.tabs.expanded
opt.softtabstop = cfg.tabs.width

-- cursor
opt.cursorline = cfg.cursors.line
opt.cursorcolumn = cfg.cursors.column

-- color
opt.termguicolors = true

--- scroll off
opt.scrolloff = cfg.cursors.scrolloff

-- smart search
opt.ignorecase = true
opt.smartcase = true

-- new left column for LSP
opt.signcolumn = "yes"

-- for lualine
opt.showmode = false

-- mouse
opt.mouse:append("a")

-- split window
opt.splitbelow = true
opt.splitright = true

-- no swap file
opt.swapfile = false

-- for neovide
if vim.g.neovide then
	vim.o.guifont = "UbuntuMono Nerd Font:h15"
	vim.g.neovide_remenber_window_size = true
end
