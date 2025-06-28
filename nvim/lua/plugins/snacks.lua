local function getCurrentFolderPath()
	-- return vim.fn.substitute(vim.fn.expand("%:p"), vim.fn.expand("%:t"), "", "")
	return vim.fn.expand("%:p:h")
end
return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				enabled = true,
				layout = {
					fullscreen = true,
					layout = {
						box = "horizontal",
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
						{ win = "preview", title = "{preview}", border = "rounded", width = 0.4 },
					}
				},
				formatters = {
					text = {
						ft = nil,
					},
					file = {
						filename_first = false, -- display filename before the file path
						truncate = 180, -- truncate the file path to (roughly) this length
						filename_only = false, -- only show the filename
						icon_width = 2, -- width of the icon (in characters)
						git_status_hl = true, -- use the git status highlight group for the filename
					},
				},
			},
			notifier = { enabled = true },
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			quickfile = { enabled = true },
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
			},
			input = { enabled = false },
			scope = { enabled = false },
			scroll = {
				enabled = false,
				animate = {
					duration = { step = 15, total = 150 },
					easing = "linear",
				},
				-- faster animation when repeating scroll after delay
				animate_repeat = {
					delay = 100, -- delay in ms before using the repeat animation
					duration = { step = 5, total = 25 },
					easing = "linear",
				},
			},
			statuscolumn = { enabled = false }, -- lazyvim handles that
			toggle = { enabled = false },
			words = { enabled = false },
			lazygit = {
				configure = true,
				win = {
					style = "lazygit",
				},
			},
		},
		keys = {
			{
				"<leader>n",
				false,
			},
			{
				"<leader>un",
				false,
			},
			-- lazygit
			{
				"<C-g>",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			-- Files
			{
				"<C-M-p>",
				function()
					Snacks.picker.files()
				end,
				desc = "Smart Find Files",
			},
			{
				"<M-S-p>",
				function()
					Snacks.picker.files({ dirs = { getCurrentFolderPath() } })
				end,
				desc = "Smart Find Files",
			},
			{
				"<C-p>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			-- grep
			-- { "<C-M-l>", function() Snacks.picker.grep() end, desc = "Grep" },
			-- { "<M-S-l>", function() Snacks.picker.grep({dirs = {getCurrentFolderPath()}}) end, desc = "Grep" },
			{
				"<C-M-f>",
				function()
					Snacks.picker.grep_word({
						live = true,
						regex = true,
					})
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{
				"<M-S-f>",
				function()
					Snacks.picker.grep_word({
						dirs = { getCurrentFolderPath() },
						regex = true,
						live = true,
					})
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{
				"<C-f>",
				function()
					Snacks.picker.lines({ regex = true })
				end,
				desc = "Buffer Lines",
			},
			-- search
			{
				"<leader>fj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>kp",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			-- -- explorer
			-- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
			--lsp
			-- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			-- {
			-- 	"gD",
			-- 	function()
			-- 		Snacks.picker.lsp_declarations()
			-- 	end,
			-- 	desc = "Goto Declaration",
			-- },
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols({
						layout = { preset = "sidebar", preview = "main" },
						main = {
							current = true,
						},
					})
				end,
				desc = "LSP Symbols",
			},

			{
				"<leader>nh",
				function()
					require("snacks").notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>nd",
				function()
					require("snacks").notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
		},
	},
}
