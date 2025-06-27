return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ "linrongbin16/lsp-progress.nvim",
				opts = {},
				lazy = false
			},
			{ "yavorski/lualine-macro-recording.nvim" }
		},
		lazy = false,
		config = function()
			local lualine = require("lualine")
			lualine.setup({
				options = {
					refresh = {
						tabline = math.huge,
						winbar = math.huge,
					},
				},
				sections = {
					lualine_a = {
						{"macro_recording", "%S"},
					},
					lualine_c = {
						{function()
							local statusline = require('arrow.statusline')
							return statusline.text_for_statusline_with_icons()
						end},
						{'filename'}
					},

					lualine_x = {
						function()
							-- invoke `progress` here.
							return require("lsp-progress").progress()
						end,
					},
					lualine_y = {
						{
							function()
								local current_line = vim.fn.line(".")
								local total_lines = vim.fn.line("$")
								local width = 10

								if total_lines <= 1 then
									return string.rep("▁", width)
								end

								local progress = (current_line - 1) / (total_lines - 1)
								local filled = math.floor(progress * width + 0.5)

								local bar = string.rep("█", filled) .. string.rep("▁", width - filled)
								return bar
							end,
							color = { fg = "#5e81ac" }, -- light blue
							separator = "",
						},
					},
					lualine_z = {
						{ "location", padding = { left = 0, right = 1 } },
					},
				},
				always_show_tabline = false,
			})
			-- listen lsp-progress event and refresh lualine
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end,
	},
}
