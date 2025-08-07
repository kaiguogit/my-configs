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
						"angular-language-server",
						"eslint-lsp",
						"json-lsp",
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
			format_on_save = function(bufnr)
				-- Disable autoformat on certain filetypes
				-- local ignore_filetypes = { "sql", "java" }
				-- if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				-- 	return
				-- end
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable autoformat for files in a certain path
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				local result = { timeout_ms = 500, lsp_format = "fallback" }
				if "ts" == vim.bo[bufnr].filetype then
					return result
				end
				if "html" == vim.bo[bufnr].filetype and bufname:match("migadmin/pkg/angular") then
					return result
				end
				return
				-- ...additional logic...
			end,
			-- format_on_save = {
			-- 	timeout_ms = 500,
			-- 	lsp_format = "first",
			-- 	filter = function(client)
			-- 		return client.name == "eslint"
			-- 	end,
			-- },
		},
	},
}
