return {
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
			and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"nvim-cmp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
				},
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		-- stylua: ignore
		keys = {
			{
				"<c-.>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<c-.>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{ "<c-.>", function() require("luasnip").jump(1) end,  mode = "s" },
			{ "<c-,>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},

		config = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()

			cmp.setup({
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = function(_, item)
						local icons = require("util.symbols").icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<C-h>'] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			})
		end,
	},
}
