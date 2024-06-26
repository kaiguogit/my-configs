local silentopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
vim.keymap.set("n", "<leader>gfh", ":G log --pretty=oneline --follow -p -20 -- %<CR>", silentopts)
vim.keymap.set("n", "<leader>ggl", ":G log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>", silentopts)

vim.keymap.set("v", "<leader>gl", function()
	vim.cmd(
		'G log --pretty="tformat: %Creset%n****************************************************************************************%n%Cred%h%Creset %Cgreen%s%Creset (%cr)" -L'
			.. vim.fn.line("v")
			.. ","
			.. vim.fn.line(".")
			.. ":"
			.. vim.fn.expand("%:p")
	)
end, {})

vim.keymap.set("n", "<leader>gl", function()
	vim.cmd(
		'G log --pretty="tformat: %Creset%n****************************************************************************************%n%Cred%h%Creset %Cgreen%s%Creset (%cr)" -L'
			.. math.max(1, vim.fn.line(".") - 1)
			.. ","
			.. vim.fn.line(".") + 1
			.. ":"
			.. vim.fn.expand("%:p")
	)
end, {})
