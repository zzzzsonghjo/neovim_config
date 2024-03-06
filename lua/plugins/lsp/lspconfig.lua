return {
	{
		"neovim/nvim-lspconfig",
		event = require("util.configs").LazyFile,

		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "definition" })
					vim.keymap.set('n', 'K', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "signature help" })
					vim.keymap.set('n', 'J', vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "references" })
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "code action" })
					vim.keymap.set('n', '<leader>cf', function()
						vim.lsp.buf.format { async = true }
					end, { buffer = ev.buf, desc = "format" })
				end,
			})

			local navic = require("nvim-navic")

			require("lspconfig").clangd.setup {
				on_attach = function(client, bufnr)
					navic.attach(client, bufnr)
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

			require("lspconfig").cmake.setup {
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
