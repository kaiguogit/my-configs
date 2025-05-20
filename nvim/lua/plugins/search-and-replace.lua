return {
	{
		"dyng/ctrlsf.vim",
		lazy = false,
		keys = {
			{ "<leader>sfw", "<Plug>CtrlSFCwordPath", desc = "S&R Word Under Cursor" },
			{ "<leader>sfb", "<Plug>CtrlSFCCwordPath", desc = "S&R Word Under Cursor (With Boundaries)" },
			{ "<leader>sfl", "<Plug>CtrlSFPwordPath", desc = "S&R Last Search Path" },
			{ "<leader>sfv", "<Plug>CtrlSFVwordPath", desc = "S&R Word Under Cursor", mode = "x" },
		},
		init = function()
			vim.g.ctrlsf_backend = "rg"
			vim.g.ctrlsf_extra_backend_args = {
				rg = "--hidden",
			}
			vim.g.ctrlsf_parse_speed = 250
			vim.g.ctrlsf_auto_focus = {
				at = "start",
			}
			vim.g.ctrlsf_fold_result = 1
			vim.g.ctrlsf_populate_qflist = 1
			vim.g.ctrlsf_regex_pattern = 1
			vim.g.ctrlsf_default_view_mode = "normal"
			vim.g.ctrlsf_auto_preview = 1
			vim.g.ctrlsf_search_mode = "async"
			vim.g.ctrlsf_ignore_dir =
				{ "bower_components", "node_modules", "dist", "build", ".git", ".idea", "reports", ".nyc_output" }
			vim.g.ctrlsf_extra_root_markers = { ".git", "package.json", "yarn.lock", "package-lock.json" }
			vim.g.ctrlsf_position = "bottom"
			vim.g.ctrlsf_context = "-C 0"
			vim.g.ctrlsf_mapping = {
				open = { "<CR>", "o" },
				openb = "O",
				split = "<C-O>",
				vsplit = "",
				tab = "t",
				tabb = "T",
				popen = "p",
				popenf = "P",
				quit = "q",
				next = "<C-J>",
				prev = "<C-K>",
				nfile = "n",
				pfile = "N",
				pquit = "q",
				loclist = "",
				chgmode = "M",
				stop = "<C-C>",
			}
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>sx",
				function()
					require("ssr").open()
				end,
				desc = "Search & Replace",
				mode = { "n", "x" },
			},
		},
		opts = {
			border = "rounded",
			min_width = 50,
			min_height = 5,
			max_width = 120,
			max_height = 25,
			adjust_window = true,
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_confirm = "<cr>",
				replace_all = "<leader><cr>",
			},
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>rw",
				function()
					require("grug-far").open({ transient = true, prefills = { search = vim.fn.expand("<cword>") } })
				end,
				mode = { "n" },
				desc = "grug-far: Search current word",
			},
			{
				"<leader>rw",
				function()
					require("grug-far").with_visual_selection({ transient = true })
				end,
				mode = { "v" },
				desc = "grug-far: Search current word",
			},
			{
				"<leader>rp",
				function()
					require("grug-far").open({
						transient = true,
						prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") },
					})
				end,
				mode = { "n" },
				desc = "grug-far: Search on current file",
			},
			{
				"<leader>rp",
				function()
					require("grug-far").with_visual_selection({
						transient = true,
						prefills = { paths = vim.fn.expand("%") },
					})
				end,
				mode = { "v" },
				desc = "grug-far: Search on current file",
			},
		},
	},
	-- show search occurence count
	{
		"kevinhwang91/nvim-hlslens",
		lazy = false,
		dependencies = {
			{
				-- "haya14busa/vim-asterisk",
				-- config = function()
				-- 	require("asterisk").setup()
				-- end,
			},
			{
				"petertriho/nvim-scrollbar",
				config = function()
					require("scrollbar").setup()
				end,
			},
		},
		config = function()
			require("hlslens").setup()
			local kopts = { noremap = true, silent = true }

			vim.keymap.set(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)

			vim.keymap.set(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.keymap.set("n", "*", [[*zz<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.keymap.set("n", "#", [[#zz<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)


			vim.keymap.set("n", "<Leader>l", "<Cmd>noh<CR>", kopts)
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
	},
}
