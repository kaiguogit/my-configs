return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				float_opts = {
					border = 'single',
					width = 270,
					height = 72,
					row = 2,
					winblend = 3,
				},
			})

			-- Lazy git
			-- vim.keymap.set("n", "<C-g>", "<cmd>LazyGit<CR>")
			-- local Terminal = require("toggleterm.terminal").Terminal
			-- local lazygit = Terminal:new({
			-- 	cmd = "lazygit",
			-- 	dir = "git_dir",
			-- 	direction = "tab",
			-- 	-- size = function(term)
			-- 	--  return vim.o.columns
			-- 	-- end,
			-- 	float_opts = {
			-- 		border = "single",
			-- 	},
			-- 	-- function to run on opening the terminal
			-- 	on_open = function(term)
			-- 		vim.cmd("startinsert!")
			-- 		vim.api.nvim_buf_set_keymap(
			-- 			term.bufnr,
			-- 			"n",
			-- 			"q",
			-- 			"<cmd>close<CR>",
			-- 			{ noremap = true, silent = true }
			-- 		)
			-- 		-- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<esc>", "<esc>", { noremap = true, silent = true })
			-- 	end,
			-- 	-- function to run on closing the terminal
			-- 	on_close = function(term)
			-- 		vim.cmd("startinsert!")
			-- 	end,
			-- })
			--
			-- function _lazygit_toggle()
			-- 	lazygit:toggle()
			-- end
			-- vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
			--
			-- function _G.set_terminal_keymaps()
			-- 	local opts = { buffer = 0 }
			-- 	-- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			-- 	-- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
			-- 	-- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
			-- 	-- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
			-- 	-- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
			-- 	-- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
			-- 	-- vim.keymap.set("t", "<C-q>", [[<C-\><C-n><C-w>q]], opts)
			-- 	-- vim.keymap.set("t", "<C-q>", [[<Cmd>close<CR>]], opts)
			-- end
			-- -- vim.keymap.set("n", "<c-/>", "<cmd>ToggleTerm<CR>")
			-- vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
		end,
	},
}
