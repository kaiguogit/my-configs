return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, {
						-- "js-debug-adapter",
						"prettierd",
						-- "angular-language-server",
					})
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				typescript = { "prettierd", stop_after_first = true },
                lua = { "stylua" },
				html = { "prettierd", stop_after_first = true },
			},
		},
	},
}
