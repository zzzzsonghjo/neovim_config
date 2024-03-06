return {
	'Civitasv/cmake-tools.nvim',
	opts = {
		cmake_command = "cmake",         -- this is used to specify cmake command path
            cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
            cmake_generate_options = {
                "-DCMAKE_BUILD_TYPE=debug",
                "-DCMAKE_C_COMPILER=C:\\Users\\zhouchenyu\\scoop\\apps\\mingw-winlibs\\current\\bin\\gcc",
                "-DCMAKE_CXX_COMPILER=C:\\Users\\zhouchenyu\\scoop\\apps\\mingw-winlibs\\current\\bin\\g++",
            },
            cmake_build_options = {
                "-j4"
            },
            cmake_build_directory = "build/",            -- specify generate directory for cmake
            cmake_soft_link_compile_commands = true,     -- this will automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = false,     -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
            cmake_kits_path = "C:\\Users\\zhouchenyu\\scoop\\apps\\mingw-winlibs\\current\\bin\\cmake",          -- specify global cmake kits path
            cmake_variants_message = {
                short = { show = true },                 -- whether to show short message
                long = { show = true, max_length = 40 }, -- whether to show long message
            },
            cmake_dap_configuration = {                  -- debug settings for cmake
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_executor = {                   -- executor to use
                name = "quickfix",               -- name of the executor
                opts = {},                       -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
                default_opts = {                 -- a list of default and possible values for executors
                    quickfix = {
                        show = "always",         -- "always", "only_on_error"
                        position = "belowright", -- "bottom", "top"
                        size = 10,
                        encoding = "utf-8",      -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
                    },
                    overseer = {
                        new_task_opts = {},               -- options to pass into the `overseer.new_task` command
                        on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {},                        -- terminal executor uses the values in cmake_terminal
                },
            },
            cmake_terminal = {
                name = "terminal",
                opts = {
                    name = "Main Terminal",
                    prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                    split_direction = "horizontal", -- "horizontal", "vertical"
                    split_size = 11,

                    -- Window handling
                    single_terminal_per_instance = true,  -- Single viewport, multiple windows
                    single_terminal_per_tab = true,       -- Single viewport per tab
                    keep_terminal_static_location = true, -- Static location of the viewport if avialable

                    -- Running Tasks
                    start_insert_in_launch_task = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                    start_insert_in_other_tasks = false, -- If you want to enter terminal with :startinsert upon launching all other cmake tasks in the terminal. Generally set as false
                    focus_on_main_terminal = false,      -- Focus on cmake terminal when cmake task is launched. Only used if executor is terminal.
                    focus_on_launch_terminal = false,    -- Focus on cmake launch terminal when executable target in launched.
                },
            },
            cmake_notifications = {
                enabled = true, -- show cmake execution progress in nvim-notify
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
                refresh_rate_ms = 100, -- how often to iterate icons
            },
	},
	event = require("util.configs").LazyFile,
}
