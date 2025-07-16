return {
	{ "tpope/vim-eunuch" },
	{
		"tpope/vim-fugitive",
		config = function()
			local silentopts = { noremap = true, silent = true }
			-- vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
			-- show commit with hash in current + register
			vim.keymap.set(
				"n",
				"<leader>gsh",
				":vert G --paginate show <C-r>+ -- %<Left><Left><Left><Left><Left>",
				silentopts
			)
			local function get_visual_selection()
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})

				text = string.gsub(text, "\n", "")
				if #text > 0 then
					return text
				else
					return ""
				end
			end

			vim.keymap.set("n", "<leader>gaa", function()
				vim.cmd("G add %")
			end, { desc = "Run git add for current file" })

			vim.keymap.set("n", "<leader>gd", function()
				vim.cmd("G diff")
			end, {})

			vim.keymap.set("n", "<leader>gs", function()
				vim.cmd("G status")
			end, {})

			vim.keymap.set("v", "<leader>gsh", function()
				vim.cmd("vert G --paginate show " .. get_visual_selection())
			end, {})

			vim.keymap.set("v", "<leader>gsd", function()
				vim.cmd("DiffviewOpen " .. get_visual_selection())
			end, {})

			-- Log current file history and patch
			-- without remerge-diff
			vim.keymap.set(
				"n",
				"<leader>gfh",
				":vert G --paginate log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --follow -p -20 -- %<CR>",
				silentopts
			)
			-- Log current file history and patch
			-- with remerge-diff
			vim.keymap.set(
				"n",
				"<leader>gfm",
				":vert G --paginate log --remerge-diff --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --follow -p -20 -- %<CR>",
				silentopts
			)
			-- Log current file history graph
			vim.keymap.set(
				"n",
				"<leader>ggl",
				":vert G --paginate log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>",
				silentopts
			)

			-- Show history for selected lines
			vim.keymap.set("v", "<leader>gl", function()
				vim.cmd(
					'vert G --paginate log --remerge-diff --pretty="tformat: %Creset%n****************************************************************************************'
						.. '%n%Cred%h%Creset %Cgreen%s%Creset%Cgreen(%cr) %C(bold blue)<%an>%Creset" -L'
						.. vim.fn.line("v")
						.. ","
						.. vim.fn.line(".")
						.. ":"
						.. vim.fn.expand("%:p")
				)
			end, {})

			-- Show history for current line
			vim.keymap.set("n", "<leader>gl", function()
				vim.cmd(
					'vert G --paginate log --remerge-diff --pretty="tformat: %Creset%n****************************************************************************************'
						.. '%n%Cred%h%Creset %Cgreen%s%Creset%Cgreen(%cr) %C(bold blue)<%an>%Creset" -L'
						.. math.max(1, vim.fn.line(".") - 1)
						.. ","
						.. vim.fn.line(".") + 1
						.. ":"
						.. vim.fn.expand("%:p")
				)
			end, {})
		end,
	},
	{
		"gregorias/coerce.nvim",
		tag = "v4.1.0",
		config = true,
	},
	{ "tpope/vim-repeat" },
	{ "kylechui/nvim-surround" },
	{ "tpope/vim-characterize" },
}
