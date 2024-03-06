local TermMode = {
	Vim = 1, ToggleTerm = 2, FloatTerm = 3
}

local time = vim.fn.stdpath("config") .. "/lua/config/time.exe"

local M = {
	map = function(mode, lhs, rhs, opts)
		local modes = type(mode) == "string" and { mode } or mode
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			---@diagnostic disable-next-line: no-unknown
			opts.remap = nil
		end
		vim.keymap.set(modes, lhs, rhs, opts)
	end,

	pattern_map = function(pattern, mode, lhs, rhs, opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = pattern,
			callback = function()
				vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
			end,
		})
	end,

	OS = function()
		local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
		if BinaryFormat == "dll" then
			function os.name()
				return "Windows"
			end
		elseif BinaryFormat == "so" then
			function os.name()
				return "Linux"
			end
		elseif BinaryFormat == "dylib" then
			function os.name()
				return "MacOS"
			end
		end
		BinaryFormat = nil
	end,

	TermMode = TermMode,


	wind_run_keys = {
		{ key = "<leader>fR",  pattern = "c",      desc = "Run single file",                 command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && " .. time .. " %:t:r" },
		{ key = "<leader>fR",  pattern = "cpp",    desc = "Run single file",                 command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && " .. time .. " %:t:r" },
		{ key = "<leader>fR",  pattern = "python", desc = "Run single file",                 command = "" .. time .. " python3 %" },
		{ key = "<leader>fR",  pattern = "lua",    desc = "Run single file",                 command = "" .. time .. " lua %" },
		{ key = "<leader>fC",  pattern = "c",      desc = "Compile single file",             command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g" },
		{ key = "<leader>fC",  pattern = "cpp",    desc = "Compile single file",             command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g" },

		{ key = "<leader>tr",  pattern = "c",      desc = "Run single file(ToggleTerm)",     command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && " .. time .. " %:t:r",       mode = TermMode.ToggleTerm },
		{ key = "<leader>tr",  pattern = "cpp",    desc = "Run single file(ToggleTerm)",     command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && " .. time .. " %:t:r", mode = TermMode.ToggleTerm },
		{ key = "<leader>tr",  pattern = "python", desc = "Run single file(ToggleTerm)",     command = "" .. time .. " python3 %",                                                mode = TermMode.ToggleTerm },
		{ key = "<leader>tr",  pattern = "lua",    desc = "Run single file(ToggleTerm)",     command = "" .. time .. " lua %",                                                    mode = TermMode.ToggleTerm },
		{ key = "<leader>tc",  pattern = "c",      desc = "Compile single file(ToggleTerm)", command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g",                               mode = TermMode.ToggleTerm },
		{ key = "<leader>tc",  pattern = "cpp",    desc = "Compile single file(ToggleTerm)", command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g",                         mode = TermMode.ToggleTerm },

		{ key = "<leader>tR",  pattern = "c",      desc = "Run single file(FloatTerm)",      command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && " .. time .. " %:t:r",       mode = TermMode.FloatTerm },
		{ key = "<leader>tR",  pattern = "cpp",    desc = "Run single file(FloatTerm)",      command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && " .. time .. " %:t:r", mode = TermMode.FloatTerm },
		{ key = "<leader>tR",  pattern = "python", desc = "Run single file(FloatTerm)",      command = "" .. time .. " python3 %",                                                mode = TermMode.FloatTerm },
		{ key = "<leader>tR",  pattern = "lua",    desc = "Run single file(FloatTerm)",      command = "" .. time .. " lua %",                                                    mode = TermMode.FloatTerm },
		{ key = "<leader>tC",  pattern = "c",      desc = "Compile single file(FloatTerm)",  command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g",                               mode = TermMode.FloatTerm },
		{ key = "<leader>tC",  pattern = "cpp",    desc = "Compile single file(FloatTerm)",  command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g",                         mode = TermMode.FloatTerm },

		{ key = "<leader>cmm", pattern = nil,      desc = "Make file",                       command = "make" },
		{ key = "<leader>cmr", pattern = nil,      desc = "Run",                             command = "" .. time .. " make run" },
		{ key = "<leader>cmR", pattern = nil,      desc = "Make and run",                    command = "make && " .. time .. " make run" },
		{ key = "<leader>cmc", pattern = nil,      desc = "Make clean",                      command = "make clean" },
		{ key = "<leader>cmC", pattern = nil,      desc = "Make&run&clean",                  command = "make && " .. time .. " make run && make clean" },

		{ key = "<leader>tmm", pattern = nil,      desc = "Make file(ToggleTerm)",           command = "make",                                                                    mode = TermMode.ToggleTerm },
		{ key = "<leader>tmr", pattern = nil,      desc = "Run(ToggleTerm)",                 command = "" .. time .. " make run",                                                 mode = TermMode.ToggleTerm },
		{ key = "<leader>tmR", pattern = nil,      desc = "Make and run(ToggleTerm)",        command = "make && " .. time .. " make run",                                         mode = TermMode.ToggleTerm },
		{ key = "<leader>tmc", pattern = nil,      desc = "Make clean(ToggleTerm)",          command = "make clean",                                                              mode = TermMode.ToggleTerm },
		{ key = "<leader>tmC", pattern = nil,      desc = "Make&run&clean(ToggleTerm)",      command = "make && " .. time .. " make run && make clean",                           mode = TermMode.ToggleTerm },

		{ key = "<leader>tMm", pattern = nil,      desc = "Make file(FloatTerm)",            command = "make",                                                                    mode = TermMode.FloatTerm },
		{ key = "<leader>tMr", pattern = nil,      desc = "Run(FloatTerm)",                  command = "" .. time .. " make run",                                                 mode = TermMode.FloatTerm },
		{ key = "<leader>tMR", pattern = nil,      desc = "Make and run(FloatTerm)",         command = "make && " .. time .. " make run",                                         mode = TermMode.FloatTerm },
		{ key = "<leader>tMc", pattern = nil,      desc = "Make clean(FloatTerm)",           command = "make clean",                                                              mode = TermMode.FloatTerm },
		{ key = "<leader>tMC", pattern = nil,      desc = "Make&run&clean(FloatTerm)",       command = "make && " .. time .. " make run && make clean",                           mode = TermMode.FloatTerm },
	},

	unix_run_keys = {
		{ key = "<leader>fR",  pattern = "c",      desc = "Run single file",                 command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && time ./%:t:r" },
		{ key = "<leader>fR",  pattern = "cpp",    desc = "Run single file",                 command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && time ./%:t:r" },
		{ key = "<leader>fR",  pattern = "python", desc = "Run single file",                 command = "time python3 %" },
		{ key = "<leader>fC",  pattern = "c",      desc = "Compile single file",             command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g" },
		{ key = "<leader>fC",  pattern = "cpp",    desc = "Compile single file",             command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g" },

		{ key = "<leader>tr",  pattern = "c",      desc = "Run single file(ToggleTerm)",     command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && time ./%:t:r",       mode = TermMode.ToggleTerm },
		{ key = "<leader>tr",  pattern = "cpp",    desc = "Run single file(ToggleTerm)",     command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && time ./%:t:r", mode = TermMode.ToggleTerm },
		{ key = "<leader>tr",  pattern = "python", desc = "Run single file(ToggleTerm)",     command = "time python3 %",                                                  mode = TermMode.ToggleTerm },
		{ key = "<leader>tc",  pattern = "c",      desc = "Compile single file(ToggleTerm)", command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g",                       mode = TermMode.ToggleTerm },
		{ key = "<leader>tc",  pattern = "cpp",    desc = "Compile single file(ToggleTerm)", command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g",                 mode = TermMode.ToggleTerm },

		{ key = "<leader>tR",  pattern = "c",      desc = "Run single file(FloatTerm)",      command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g && time ./%:t:r",       mode = TermMode.FloatTerm },
		{ key = "<leader>tR",  pattern = "cpp",    desc = "Run single file(FloatTerm)",      command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g && time ./%:t:r", mode = TermMode.FloatTerm },
		{ key = "<leader>tR",  pattern = "python", desc = "Run single file(FloatTerm)",      command = "time python3 %",                                                  mode = TermMode.FloatTerm },
		{ key = "<leader>tC",  pattern = "c",      desc = "Compile single file(FloatTerm)",  command = "gcc -std=c11 -Wshadow -Wall -o %:t:r % -g",                       mode = TermMode.FloatTerm },
		{ key = "<leader>tC",  pattern = "cpp",    desc = "Compile single file(FloatTerm)",  command = "g++ -std=c++14 -Wshadow -Wall -O2 -o %:t:r % -g",                 mode = TermMode.FloatTerm },

		{ key = "<leader>cmm", pattern = nil,      desc = "Make file",                       command = "make" },
		{ key = "<leader>cmr", pattern = nil,      desc = "Run",                             command = "time make run" },
		{ key = "<leader>cmR", pattern = nil,      desc = "Make and run",                    command = "make && time make run" },
		{ key = "<leader>cmc", pattern = nil,      desc = "Make clean",                      command = "make clean" },
		{ key = "<leader>cmC", pattern = nil,      desc = "Make&run&clean",                  command = "make && time make run && make clean" },

		{ key = "<leader>tmm", pattern = nil,      desc = "Make file(ToggleTerm)",           command = "make",                                                            mode = TermMode.ToggleTerm },
		{ key = "<leader>tmr", pattern = nil,      desc = "Run(ToggleTerm)",                 command = "time make run",                                                   mode = TermMode.ToggleTerm },
		{ key = "<leader>tmR", pattern = nil,      desc = "Make and run(ToggleTerm)",        command = "make && time make run",                                           mode = TermMode.ToggleTerm },
		{ key = "<leader>tmc", pattern = nil,      desc = "Make clean(ToggleTerm)",          command = "make clean",                                                      mode = TermMode.ToggleTerm },
		{ key = "<leader>tmC", pattern = nil,      desc = "Make&run&clean(ToggleTerm)",      command = "make && time make run && make clean",                             mode = TermMode.ToggleTerm },

		{ key = "<leader>tMm", pattern = nil,      desc = "Make file(FloatTerm)",            command = "make",                                                            mode = TermMode.FloatTerm },
		{ key = "<leader>tMr", pattern = nil,      desc = "Run(FloatTerm)",                  command = "time make run",                                                   mode = TermMode.FloatTerm },
		{ key = "<leader>tMR", pattern = nil,      desc = "Make and run(FloatTerm)",         command = "make && time make run",                                           mode = TermMode.FloatTerm },
		{ key = "<leader>tMc", pattern = nil,      desc = "Make clean(FloatTerm)",           command = "make clean",                                                      mode = TermMode.FloatTerm },
		{ key = "<leader>tMC", pattern = nil,      desc = "Make&run&clean(FloatTerm)",       command = "make && time make run && make clean",                             mode = TermMode.FloatTerm },
	},
}

return M
