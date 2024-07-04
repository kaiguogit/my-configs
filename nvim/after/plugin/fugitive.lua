local silentopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
vim.keymap.set("n", "<leader>gsh", ":vert G --paginate show <C-r>+ -- %<Left><Left><Left><Left><Left>", silentopts)
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
vim.keymap.set("v", "<leader>gsh", function()
	vim.cmd("vert G --paginate show " .. get_visual_selection())
end, {})

vim.keymap.set(
	"n",
	"<leader>gfh",
	":vert G --paginate log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --follow -p -20 -- %<CR>",
	silentopts
)
vim.keymap.set(
	"n",
	"<leader>ggl",
	":vert G --paginate log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit<CR>",
	silentopts
)

vim.keymap.set("v", "<leader>gl", function()
	vim.cmd(
		'vert G --paginate log --pretty="tformat: %Creset%n****************************************************************************************'
			.. '%n%Cred%h%Creset %Cgreen%s%Creset%Cgreen(%cr) %C(bold blue)<%an>%Creset" -L'
			.. vim.fn.line("v")
			.. ","
			.. vim.fn.line(".")
			.. ":"
			.. vim.fn.expand("%:p")
	)
end, {})

vim.keymap.set("n", "<leader>gl", function()
	vim.cmd(
		'vert G --paginate log --pretty="tformat: %Creset%n****************************************************************************************'
			.. '%n%Cred%h%Creset %Cgreen%s%Creset%Cgreen(%cr) %C(bold blue)<%an>%Creset" -L'
			.. math.max(1, vim.fn.line(".") - 1)
			.. ","
			.. vim.fn.line(".") + 1
			.. ":"
			.. vim.fn.expand("%:p")
	)
end, {})
