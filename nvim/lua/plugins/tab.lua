return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			{ "lewis6991/gitsigns.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("barbar").setup({
				icons = {
					pinned = { button = "", filename = true },
				},
			})
		end,
	},
}
