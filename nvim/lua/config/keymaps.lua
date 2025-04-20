vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmdd.Ex)
-- vim.keymap.set("n", "<leader>pv", ":Neotree source=filesystem reveal_force_cwd left<CR>")
--vim.keymap.set("n", "<leader>fb", ":Neotree source=buffers reveal_force_cwd left<CR>")
-- vim.keymap.set(
--   "n",
--   "<space>pv",
--   ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
--   { noremap = true }
-- )

-- Delete default lazyvim keymap
vim.keymap.del({ "n", "t" }, "<c-/>")
vim.keymap.del({ "n", "t" }, "<c-_>")
vim.keymap.del("n", "<leader>sj")
vim.keymap.del("n", "s")
vim.keymap.del("n", "<leader>gl")

-- my key maps
vim.keymap.set("n", "<c-_>", "<cmd>ToggleTerm<CR>")
vim.keymap.set("t", "<c-_>", "<cmd>close<CR>")

local silentopts = { noremap = true, silent = true }
-- Buffer navigation
-- Navigate to buffer
vim.keymap.set("n", "<A-,>", "<cmd>BufferPrevious<CR>", silentopts)
vim.keymap.set("n", "<A-.>", "<cmd>BufferNext<CR>", silentopts)
-- Move buffer
vim.keymap.set("n", "<A-<>", "<cmd>BufferMovePrevious<CR>", silentopts)
vim.keymap.set("n", "<A->>", "<cmd>BufferMoveNext<CR>", silentopts)
-- Go to buffer position
vim.keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<CR>", silentopts)
vim.keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<CR>", silentopts)
vim.keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<CR>", silentopts)
vim.keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<CR>", silentopts)
vim.keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<CR>", silentopts)
vim.keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<CR>", silentopts)
vim.keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<CR>", silentopts)
vim.keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<CR>", silentopts)
vim.keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<CR>", silentopts)
vim.keymap.set("n", "<A-0>", "<cmd>BufferGoto 0<CR>", silentopts)
-- Pin/unpin buffer
vim.keymap.set("n", "<A-p>", "<cmd>BufferPin<CR>", silentopts)
-- Close buffer
vim.keymap.set("n", "<A-c>", "<cmd>BufferClose<CR>", silentopts)
-- vim.keymap.set("n", "z;", ":bp<bar>sp<bar>bn<bar>bd<CR>", silentopts)
-- Restore buffer
vim.keymap.set("n", "<A-s-c>", "<cmd>BufferRestore<CR>", silentopts)

-- Wipeout buffer
--                          :BufferWipeout
-- Close commands
--                          :BufferCloseAllButCurrent
--                          :BufferCloseAllButVisible
--                          :BufferCloseAllButPinned
--                          :BufferCloseAllButCurrentOrPinned
--                          :BufferCloseBuffersLeft
--                          :BufferCloseBuffersRight

-- close this file
-- close all
-- vim.keymap.set("n", "zd", ":%bd<CR>", silentopts)
vim.keymap.set("n", "zd", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", silentopts)
-- %bd – Deletes all open buffers (bd is short for bdelete)
-- e# – Opens the last buffer (e is short for edit)
-- bd# – Deletes the [No Name] buffer that gets created
-- vim.keymap.set("n", "<leader>bd", "<cmd>%bd|e#|bd#<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { silent = true })

-- Quickfix shortcuts
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", silentopts)
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", silentopts)
vim.keymap.set("n", "qc", "<cmd>cclose<CR>", silentopts)
vim.keymap.set("n", "qo", "<cmd>copen<CR>", silentopts)

-- rename append
vim.keymap.set("n", "<leader>ra", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", silentopts)
-- rename replace
vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>", silentopts)
-- Search what's in register and apply last command. It can be used to trigger rename on next occurance
vim.keymap.set("n", "<leader>rs", '/<C-r>"<CR>.', { noremap = false })

-- tabs
vim.keymap.set("n", "th", ":tabfirst<CR>", silentopts)
vim.keymap.set("n", "tl", ":tablast<CR>", silentopts)
vim.keymap.set("n", "tj", ":tabprev<CR>", silentopts)
vim.keymap.set("n", "tk", ":tabnext<CR>", silentopts)
vim.keymap.set("n", "tt", ":tabedit<CR>", silentopts)
vim.keymap.set("n", "td", ":tabclose<CR>", silentopts)
vim.keymap.set("n", "tn", ":tabnew %<CR>", silentopts)
vim.keymap.set("n", "to", ":tabonly<CR>", silentopts)
vim.keymap.set("n", "ts", ":tab split<CR>", silentopts)

-- quick save and close
vim.keymap.set("n", "<leader>s", ":w<CR>", silentopts)
vim.keymap.set("n", "<leader>q", ":x<CR>", silentopts)

-- vim shortcuts
-- vim.keymap.set("n", "<leader>gfh", ":G log --follow -p -5 -- %<CR>", silentopts)
-- vim.keymap.set("n", "<leader>gs", ":0G<CR>", silentopts)

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
-- vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")
vim.keymap.set("c", "<C-l>", "<Right>")
vim.keymap.set("c", "<C-h>", "<Left>")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zz")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- paste without changing the buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- copy into system clipboard (+)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

local function organize_imports()
	vim.cmd("TSToolsOrganizeImports")
	-- local params = {
	-- 	command = "typescript-tools.organizeImports",
	-- 	arguments = { vim.api.nvim_buf_get_name(0) },
	-- 	title = "",
	-- }
	-- vim.lsp.buf_request_sync(0, "workspace/executeCommand", params, 3000)
end
-- vim.keymap.set("n", "<leader>f", "<space>oi<cmd>FormatWrite<CR>")
vim.keymap.set("n", "<leader>f", function(args)
	-- organize_imports()
	-- vim.cmd("TSToolsOrganizeImports")
	-- vim.cmd("FormatWrite")
	require("conform").format()
	-- vim.cmd('EslintFixAll')
end)

-- vim.keymap.set("n", "<leader>f", function()
--     -- vim.lsp.buf.format()
-- end)

-- quick fix navigation
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- set executable permission
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- quit without closing the window
-- vim.keymap.set("n", "<leader>q", ":enew<bar>bd #<CR>")

local function moveBufferTo(direction)
	local bufPath = vim.api.nvim_buf_get_name(0)

	-- Go to alternate file. Save as CTRL-6
	vim.api.nvim_exec("e#", true)
	-- commented out another way to trigger CTRL-6 but this way doesn't do it synchrounsely.
	-- local alternate_file_keys = vim.api.nvim_replace_termcodes("<C-^>", true, false, true)
	-- vim.api.nvim_feedkeys(alternate_file_keys, 'n', true)

	-- Move to the new window
	vim.api.nvim_exec("wincmd " .. direction, true)
	local new_win_id = vim.fn.winnr()
	-- Open the previous buffer
	vim.api.nvim_exec("edit" .. bufPath, true)
	-- Commented out for future reference
	-- Go back to previous window
	-- Change to alternative file
	-- local win_id = vim.fn.bufwinnr("%")
	-- vim.api.nvim_exec('wincmd ' .. win_id .. ' w', true)
	-- local alternate_file_keys = vim.api.nvim_replace_termcodes("<C-^>", true, false, true)
	-- vim.api.nvim_feedkeys(alternate_file_keys, 'n', true)
	-- -- Go back to the new window
	-- vim.api.nvim_exec('wincmd ' .. new_win_id .. ' w', true)
end

local function moveBufferTo(direction)
	local bufPath = vim.api.nvim_buf_get_name(0)
	-- Go to alternate file. Save as CTRL-6
	vim.api.nvim_exec("e#", true)
	-- Move to the new window
	vim.api.nvim_exec("wincmd " .. direction, true)
	-- Open the previous buffer
	vim.api.nvim_exec("edit" .. bufPath, true)
end

-- Move current buffer to existing window
vim.keymap.set("n", "<C-w>L", function()
	moveBufferTo("l")
end, { silent = true })
vim.keymap.set("n", "<C-w>H", function()
	moveBufferTo("h")
end, { silent = true })
vim.keymap.set("n", "<C-w>J", function()
	moveBufferTo("j")
end, { silent = true })
vim.keymap.set("n", "<C-w>K", function()
	moveBufferTo("k")
end, { silent = true })

-- copy file path
vim.keymap.set("n", "<leader>cp", ":let @+=@%<CR>")
vim.keymap.set("n", "<leader>cn", ':let @+ = expand("%:t")<CR>')

-- LSP
local opts = { remap = false }

vim.keymap.set("n", "gh", function()
	vim.lsp.buf.hover()
end, opts)
vim.keymap.set("n", "<leader>vws", function()
	vim.lsp.buf.workspace_symbol()
end, opts)
vim.keymap.set("n", "ge", function()
	vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
end, opts)
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, opts)
-- Used <leader>fr in telescope.lua
-- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "gd", function()
	vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "<leader>vrn", function()
	vim.lsp.buf.rename()
end, opts)
vim.keymap.set("n", "<leader>ph", function()
	vim.lsp.buf.signature_help()
end, opts)
vim.keymap.set("n", "<leader>oi", organize_imports)
