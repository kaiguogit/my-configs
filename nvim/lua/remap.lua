vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmdd.Ex)
vim.keymap.set("n", "<leader>pv", ":Neotree source=filesystem reveal_force_cwd left<CR>")
--vim.keymap.set("n", "<leader>fb", ":Neotree source=buffers reveal_force_cwd left<CR>")
-- Search what's in register and apply last command. It can be used to trigger rename on next occurance
vim.keymap.set("n", "<leader>rp", "/<C-r>\"<CR>.", { noremap = false })
-- vim.api.nvim_set_keymap(
--   "n",
--   "<space>pv",
--   ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
--   { noremap = true }
-- )

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- navigate between buffers
vim.keymap.set("n", "<C-t>", ":bp <CR>")
vim.keymap.set("n", "<C-y>", ":bn <CR>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- paste without changing the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy into system clipboard (+)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- quick fix navigation
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace the word I'm currently on
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- set executable permission
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- quit without closing the window
vim.keymap.set("n", "<leader>q", ":enew<bar>bd #<CR>")

-- copy file path
vim.keymap.set("n", "<leader>cp", ":let @+=@%<CR>")
vim.keymap.set("n", "<leader>cn", ":let @+ = expand(\"%:t\")<CR>")
