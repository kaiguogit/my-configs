return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			-- vim.list_extend(opts.ensure_installed, {
			-- 	"proselint",
			-- })
		end,
	},
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				-- Enable or disable logging
				logging = true,
				-- Set the log level
				log_level = vim.log.levels.WARN,
				-- All formatter configurations are opt-in
				filetype = {
					-- Formatter configurations for filetype "lua" go here
					-- and will be executed in order
					typescript = {
						-- require("formatter.util").withl(require("formatter.defaults").prettier, "typescript")
						require("formatter.filetypes.typescript").prettierd,
					},
					-- lua = {
					--	-- "formatter.filetypes.lua" defines default configurations for the
					--	-- "lua" filetype
					--	require("formatter.filetypes.lua").stylua
					-- },

					-- Use the special "*" filetype for defining formatter configurations on
					-- any filetype
					-- ["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any filetype
					-- require("formatter.filetypes.any").remove_trailing_whitespace,
					-- },
				},
			})
			local augroup = vim.api.nvim_create_augroup

			local autocmd = vim.api.nvim_create_autocmd
			augroup("__formatter__", { clear = true })
			autocmd("BufWritePost", {
				group = "__formatter__",
				-- command = ":FormatWrite",
				callback = function()
					vim.cmd("FormatWrite")
				end,
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				-- markdown = { "proselint" },
				-- python = { "ruff" },
				-- yaml = { "yamllint" },
			},
		},
	},
}
