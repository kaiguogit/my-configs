return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = false,
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			vim.keymap.set({ "i" }, "<M-;>", function()
				ls.expand({})
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<M-0>", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<M-9>", function()
				ls.jump(-1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<M-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
			-- For friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			-- for custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "~/.config/nvim/vscode_snippets" },
			})
			local types = require("luasnip.util.types")
			ls.config.setup({
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
		end,
	},
}
