return {
	"simrat39/symbols-outline.nvim",
	keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols outline" } },
	cmd = "SymbolsOutline",
	opts = function()
		local symbol = require("util.symbols")
		local opts = {
			symbols = {
				File = { icon = symbol.File, hl = "@text.uri" },
				Module = { icon = symbol.Module, hl = "@namespace" },
				Namespace = { icon = symbol.Namespace, hl = "@namespace" },
				Package = { icon = symbol.Package, hl = "@namespace" },
				Class = { icon = symbol.Class, hl = "@type" },
				Method = { icon = symbol.Method, hl = "@method" },
				Property = { icon = symbol.Property, hl = "@method" },
				Field = { icon = symbol.Field, hl = "@field" },
				Constructor = { icon = symbol.Constructor, hl = "@constructor" },
				Enum = { icon = symbol.Enum, hl = "@type" },
				Interface = { icon = symbol.Interface, hl = "@type" },
				Function = { icon = symbol.Function, hl = "@function" },
				Variable = { icon = symbol.Variable, hl = "@constant" },
				Constant = { icon = symbol.Constant, hl = "@constant" },
				String = { icon = symbol.String, hl = "@string" },
				Number = { icon = symbol.Number, hl = "@number" },
				Boolean = { icon = symbol.Boolean, hl = "@boolean" },
				Array = { icon = symbol.Array, hl = "@constant" },
				Object = { icon = symbol.Object, hl = "@type" },
				Key = { icon = symbol.Key, hl = "@type" },
				Null = { icon = symbol.Null, hl = "@type" },
				EnumMember = { icon = symbol.EnumMember, hl = "@field" },
				Struct = { icon = symbol.Struct, hl = "@type" },
				Event = { icon = symbol.Event, hl = "@type" },
				Operator = { icon = symbol.Operator, hl = "@operator" },
				TypeParameter = { icon = symbol.TypeParameter, hl = "@parameter" },
				Component = { icon = symbol.Component, hl = "@function" },
				Fragment = { icon = symbol.Fragment, hl = "@constant" },
			},
			symbol_blacklist = {},
		}
		return opts
	end,
}
