return {
	{
		"neovim/nvim-lspconfig",
		event = require("util.configs").LazyFile,

		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim",  opts = {} },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function(_, opts)
			local Util = require("lazyvim.util")

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature help" })
					vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
					vim.keymap.set('n', '<leader>cf', function()
						vim.lsp.buf.format { async = true }
					end, { buffer = ev.buf, desc = "format" })
				end,
			})

			-- -- setup keymaps
			-- Util.lsp.on_attach(function(client, buffer)
			-- 	require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
			-- end)

			local register_capability = vim.lsp.handlers["client/registerCapability"]

			vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
				local ret = register_capability(err, res, ctx)
				local client_id = ctx.client_id
				---@type lsp.Client
				local client = vim.lsp.get_client_by_id(client_id)
				local buffer = vim.api.nvim_get_current_buf()
				require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
				return ret
			end

			-- diagnostics
			for name, icon in pairs(require("util.symbols").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local navic = require("nvim-navic")

			require("lspconfig").clangd.setup {
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
					require("clangd_extensions.inlay_hints").setup_autocmd()
					require("clangd_extensions.inlay_hints").set_inlay_hints()
				end
			}

			require("lspconfig").lua_ls.setup {
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
				end
			}

			require("lspconfig").pyright.setup {
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
				end
			}
		end,
	},
	{
		"SmiteshP/nvim-navic",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		init = function()
			vim.g.navic_silence = true
		end,
		opts = function()
			return {
				icons = require("util.symbols"),
				lsp = {
					auto_attach = false,
					preference = nil,
				},
				highlight = false,
				separator = " > ",
				depth_limit = 0,
				depth_limit_indicator = "..",
				safe_output = true,
				lazy_update_context = false,
				click = false,
				format_text = function(text)
					return text
				end,
			}
		end,
	},
}
