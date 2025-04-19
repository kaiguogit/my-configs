local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register
	end
end
return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			local lualine = require("lualine")
			vim.api.nvim_create_autocmd("RecordingEnter", {
				callback = function()
					lualine.refresh({
						place = { "statusline" },
					})
				end,
			})

			vim.api.nvim_create_autocmd("RecordingLeave", {
				callback = function()
					-- This is going to seem really weird!
					-- Instead of just calling refresh we need to wait a moment because of the nature of
					-- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
					-- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
					-- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
					-- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
					local timer = vim.loop.new_timer()
					timer:start(
						50,
						0,
						vim.schedule_wrap(function()
							lualine.refresh({
								place = { "statusline" },
							})
						end)
					)
				end,
			})
			lualine.setup({
				options = {
					refresh = {
						tabline = math.huge,
						winbar = math.huge,
					},
				},
				sections = {
					lualine_a = { "branch" },
					lualine_b = {
						{
							"macro-recording",
							fmt = show_macro_recording,
						},
					},
					lualine_c = {},
					lualine_x = {},
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
		end,
	},
	{
		"linrongbin16/lsp-progress.nvim",
		opts = {},
		lazy = false,
		dependencies = {
			{
				"nvim-lualine/lualine.nvim",
				config = function(_, opts)
					local new_opts = {
						sections = {
							lualine_x = {
								function()
									-- invoke `progress` here.
									return require("lsp-progress").progress()
								end,
							},
						},
					}
					opts = vim.tbl_deep_extend("force", opts, new_opts)
					require("lualine").setup(opts)

					-- listen lsp-progress event and refresh lualine
					vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
					vim.api.nvim_create_autocmd("User", {
						group = "lualine_augroup",
						pattern = "LspProgressStatusUpdated",
						callback = require("lualine").refresh,
					})
				end,
			},
		},
	},
}
