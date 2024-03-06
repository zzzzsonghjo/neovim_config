local config = require("util.keymaps")

local TermMode = config.TermMode

local key_config

if config.OS == "Linux" then
	key_config = config.unix_run_keys
else
	key_config = config.wind_run_keys
end

local vimterm_pre = "<Esc>:w<Cr>:split<Cr>:te cd %:h && "
local vimterm_suf = "<Cr>i"

local ToggleT_pre = "<Esc>:w<Cr>:TermExec direction=horizontal cmd=\"cd %:h && "
local ToggleT_suf = "\"<Cr>"

local FloatTT_pre = "<Esc>:w<Cr>:TermExec direction=float cmd=\"cd %:h && "
local FloatTT_suf = "\"<Cr>"

local pres = {
	vimterm_pre, ToggleT_pre, FloatTT_pre
}

local sufs = {
	vimterm_suf, ToggleT_suf, FloatTT_suf
}

local set_key = function(key, pref, comm, suff, desc, pattern)
	if pattern == nil then
		vim.keymap.set(
			"n", key, pref .. comm .. suff, { silent = true, noremap = true, desc = desc }
		)
	else
		require("util.keymaps").pattern_map(
			pattern, "n", key, pref .. comm .. suff, { silent = true, noremap = true, desc = desc }
		)
	end
end

for _, setup in ipairs(key_config) do
	set_key(
		setup.key,
		setup.pre or pres[setup.mode or TermMode.Vim],
		setup.command,
		setup.suf or sufs[setup.mode or TermMode.Vim],
		setup.desc,
		setup.pattern
	)
end
