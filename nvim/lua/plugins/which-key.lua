return {
	{
		"folke/which-key.nvim",
		opts = {
			preset = "modern",
		},
		config = function()
			require("which-key").register({
				g = {
					p = {
						-- "p" makes sense, gv selects the last Visual selection, so this one
						-- selects the last pasted text.
						function()
							vim.api.nvim_feedkeys("`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]", "n", false)
						end,
						"Switch to VISUAL using last paste/change",
					},
				},
			})
		end,
	},
}
