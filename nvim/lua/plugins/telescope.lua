return {
	{
		-- "AckslD/nvim-neoclip.lua",
		-- This fork suport visual past
		"peterfication/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			local function is_whitespace(line)
				return vim.fn.match(line, [[^\s*$]]) ~= -1
			end

			local function all(tbl, check)
				for _, entry in ipairs(tbl) do
					if not check(entry) then
						return false
					end
				end
				return true
			end
			local function visual_paste(opts)
				local handlers = require("neoclip.handlers")
				handlers.set_registers({ "z" }, opts.entry)
				vim.api.nvim_feedkeys('gv"zp', "n", false)
			end
			-- https://github.com/AckslD/nvim-neoclip.lua/issues/128#issuecomment-2210249626
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							paste = "<cr>",
							-- paste_behind = "<c-o>",
							past_visual = "<c-s-k>",
						},
					},
				},
				filter = function(data)
					return not all(data.event.regcontents, is_whitespace)
				end,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			-- { "nvim-telescope/telescope-live-grep-args.nvim" },
			-- Use telescope for nvim core selection such as lsp code action list.
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-hop.nvim" },
			-- { "isak102/telescope-git-file-history.nvim" },
			{ "natecraddock/workspaces.nvim" },
		},
		config = function()
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")
			-- local builtin = require("telescope.builtin")
			-- local lga_actions = require("telescope-live-grep-args.actions")
			local telescope = require("telescope")
			local workspaces = require("workspaces")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
					},
					mappings = {
						i = {
							["<esc>"] = function(prompt_bufnr)
								require("telescope.actions").close(prompt_bufnr)
							end,
							["<C-j>"] = function(prompt_bufnr)
								require("telescope.actions").move_selection_next(prompt_bufnr)
							end,
							["<C-k>"] = function(prompt_bufnr)
								require("telescope.actions").move_selection_previous(prompt_bufnr)
							end,

							-- map actions.which_key to <C-h> (default: <C-/>)
							-- actions.which_key shows the mappings for your picker,
							-- e.g. git_{create, delete, ...}_branch for the git_branches picker
							-- ["<C-h>"] = "which_key"
							["<M-p>"] = action_layout.toggle_preview,
							["<M-d>"] = actions.delete_buffer + actions.move_to_top,
							["<C-s>"] = actions.cycle_previewers_next,
							["<C-a>"] = actions.cycle_previewers_prev,
							["<C-g>"] = function(prompt_bufnr)
								-- Use nvim-window-picker to choose the window by dynamically attaching a function
								local action_set = require("telescope.actions.set")
								local action_state = require("telescope.actions.state")

								local picker = action_state.get_current_picker(prompt_bufnr)
								picker.get_selection_window = function(picker, entry)
									local picked_window_id = require("window-picker").pick_window()
										or vim.api.nvim_get_current_win()
									-- Unbind after using so next instance of the picker acts normally
									picker.get_selection_window = nil
									return picked_window_id
								end

								return action_set.edit(prompt_bufnr, "edit")
							end,
							["<C-h>"] = telescope.extensions.hop.hop, -- hop.hop_toggle_selection
						},
						n = {
							["cd"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								local dir = vim.fn.fnamemodify(selection.path, ":p:h")
								require("telescope.actions").close(prompt_bufnr)
								-- Depending on what you want put `cd`, `lcd`, `tcd`
								vim.cmd(string.format("silent lcd %s", dir))
							end,
							["<M-p>"] = action_layout.toggle_preview,
							["<C-h>"] = telescope.extensions.hop.hop, -- hop.hop_toggle_selection
						},
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
					},
				},
				pickers = {
					-- Default configuration for builtin pickers goes here:
					-- picker_name = {
					--   picker_config_key = value,
					--   ...
					-- }
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
					lsp_references = {
						show_line = false,
					},
					find_files = {
						previewer = false,
						-- entry_maker = require"my_make_entry".gen_from_buffer_like_leaderf(),
					},
					git_files = {
						previewer = false,
						-- entry_maker = require"my_make_entry".gen_from_buffer_like_leaderf(),
					},
					current_buffer_fuzzy_find = {
						previewer = false,
						-- entry_maker = require"my_make_entry".gen_from_buffer_like_leaderf(),
					},
					buffers = {
						previewer = false,
						-- entry_maker = require"my_make_entry".gen_from_buffer_like_leaderf(),
					},
				},
				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
					--
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						-- for example to disable the custom builtin "codeactions" display
						-- do the following
						-- codeactions = false,
						-- }
					},
					-- live_grep_args = {
					-- 	auto_quoting = true, -- enable/disable auto-quoting
					-- 	-- define mappings, e.g.
					-- 	mappings = { -- extend mappings
					-- 		i = {
					-- 			["<C-k>"] = lga_actions.quote_prompt(),
					-- 			["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					-- 		},
					-- 	},
					-- },
					hop = {
						-- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
						keys = {
							"a",
							"s",
							"d",
							"f",
							"g",
							"h",
							"j",
							"k",
							"l",
							";",
							"q",
							"w",
							"e",
							"r",
							"t",
							"y",
							"u",
							"i",
							"o",
							"p",
						},
						-- Highlight groups to link to signs and lines; the below configuration refers to demo
						-- sign_hl typically only defines foreground to possibly be combined with line_hl
						sign_hl = { "WarningMsg", "Title" },
						-- optional, typically a table of two highlight groups that are alternated between
						line_hl = { "CursorLine", "Normal" },
						-- options specific to `hop_loop`
						-- true temporarily disables Telescope selection highlighting
						clear_selection_hl = false,
						-- highlight hopped to entry with telescope selection highlight
						-- note: mutually exclusive with `clear_selection_hl`
						trace_entry = true,
						-- jump to entry where hoop loop was started from
						reset_selection = true,
					},
					workspaces = {
						-- keep insert mode after selection in the picker, default is false
						keep_insert = true,
						-- Highlight group used for the path in the picker, default is "String"
						path_hl = "String",
					},
				},
			})

			telescope.load_extension("workspaces")
			telescope.load_extension("ui-select")
			-- telescope.load_extension("live_grep_args")
			telescope.load_extension("hop")
			telescope.load_extension("neoclip")
			-- telescope.load_extension("git_file_history")

			-- falllback to find_files if it's not a git folder
			-- We cache the results of "git rev-parse"
			-- Process creation is expensive in Windows, so this reduces latency
			-- local is_inside_work_tree = {}
			--
			-- local project_files = function()
			-- 	local opts = {
			-- 		-- entry_maker = require"my_make_entry".gen_from_buffer_like_leaderf(),
			-- 	} -- define here if you want to define something
			--
			-- 	local cwd = vim.fn.getcwd()
			-- 	if is_inside_work_tree[cwd] == nil then
			-- 		vim.fn.system("git rev-parse --is-inside-work-tree")
			-- 		is_inside_work_tree[cwd] = vim.v.shell_error == 0
			-- 	end
			--
			-- 	if is_inside_work_tree[cwd] then
			-- 		builtin.git_files(opts)
			-- 	else
			-- 		builtin.find_files(opts)
			-- 	end
			-- end
			--
			-- -- Find all files
			-- vim.keymap.set("n", "<C-M-p>", project_files, {})
			--
			workspaces.setup({
				-- hooks = {
				-- 	open = project_files,
				-- },
			})
			--
			-- local function getCurrentFolderPath()
			-- 	-- return vim.fn.substitute(vim.fn.expand("%:p"), vim.fn.expand("%:t"), "", "")
			-- 	return vim.fn.expand("%:p:h")
			-- end
			--
			-- -- Find files in current folder
			-- vim.keymap.set("n", "<M-S-p>", function()
			-- 	builtin.find_files({
			-- 		search_dirs = { getCurrentFolderPath() },
			-- 	})
			-- end)
			--
			-- -- Find fiels in current buffers
			-- -- vim.keymap.set("n", "<C-p>", builtin.buffers, { desc = "Open buffer" })
			--
			-- -- Fuzzy search in current file
			-- -- vim.keymap.set('n', '<leader>fgg', builtin.current_buffer_fuzzy_find, {})
			--
			-- local function get_visual_selection()
			-- 	vim.cmd('noau normal! "vy"')
			-- 	local text = vim.fn.getreg("v")
			-- 	vim.fn.setreg("v", {})
			--
			-- 	text = string.gsub(text, "\n", "")
			-- 	if #text > 0 then
			-- 		return text
			-- 	else
			-- 		return ""
			-- 	end
			-- end
			-- -- live grep for current file
			-- vim.keymap.set("n", "<C-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({
			-- 		default_text = vim.fn.expand("<cword>"),
			-- 		search_dirs = { vim.fn.expand("%:p") },
			-- 	})
			-- end)
			--
			-- vim.keymap.set("v", "<C-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({
			-- 		default_text = get_visual_selection(),
			-- 		search_dirs = { vim.fn.expand("%:p") },
			-- 	})
			-- end)
			--
			-- -- live grep for all files
			-- vim.keymap.set("n", "<C-M-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({ default_text = vim.fn.expand("<cword>") })
			-- end)
			-- vim.keymap.set("v", "<C-M-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({ default_text = get_visual_selection() })
			-- end)
			-- -- live grep for current folder
			-- vim.keymap.set("n", "<M-S-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({
			-- 		default_text = vim.fn.expand("<cword>"),
			-- 		search_dirs = { getCurrentFolderPath() },
			-- 	})
			-- end)
			--
			-- -- live grep for current folder
			-- vim.keymap.set("v", "<M-S-f>", function()
			-- 	telescope.extensions.live_grep_args.live_grep_args({
			-- 		default_text = get_visual_selection(),
			-- 		search_dirs = { getCurrentFolderPath() },
			-- 	})
			-- end)

			-- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Vim help tags" })
			-- vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Open LSP references" })
			vim.keymap.set("n", "<leader>pl", function()
				telescope.extensions.neoclip.default()
			end, { desc = "Open clip board" })
			vim.keymap.set("v", "<leader>pl", function()
				telescope.extensions.neoclip.default()
			end, { desc = "Open clip board" })
			vim.keymap.set("n", "<leader>pj", function()
				vim.cmd("Telescope workspaces")
			end, { desc = "Open workspaces list" })

			-- vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
			-- vim.keymap.set("n", "<leader>ghh", telescope.extensions.git_file_history.git_file_history, {})
		end,
	},
}
