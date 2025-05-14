-- fat cursor
-- vim.opt.guicursor = ""
vim.opt.guifont = "Ubuntu Mono:h18"

vim.opt.ignorecase = true
vim.opt.smartcase = true
-- line number
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.fn.setenv("GIT_EDITOR", "nvr -cc split --remote-wait +'set bufhidden=wipe'")

vim.opt.list = true

local space = "·"
vim.opt.listchars:append({
	tab = "│─",
	multispace = space,
	lead = space,
	trail = space,
	nbsp = space,
})

vim.opt.foldmethod = "indent"
-- https://www.jaykim.earth/posts/2023-06-28-gotchas-using-fs-watch-with-vim
vim.o.backupcopy = "yes"

-- https://vi.stackexchange.com/a/5318/12823
vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

vim.opt.syntax = "off"
vim.o.foldenable = false
vim.o.spell = false

-- turn off log for performance
-- https://github.com/LazyVim/LazyVim/discussions/326
vim.lsp.set_log_level("off")
-- set cmd height to 0
vim.o.cmdheight = 0
-- https://www.reddit.com/r/neovim/comments/1arkhtx/how_to_disable_format_on_save_in_lazyvim/
vim.g.autoformat = false

-- Set global status so lualine can be wide across splits
vim.o.laststatus = 3
-- Dont let escape delay too long, it becomes alt and cause escape + j to become alt-j and move line
-- https://stackoverflow.com/questions/12312178/tmux-and-vim-escape-key-being-seen-as-and-having-long-delay
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 10

function ansi_colorize()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.statuscolumn = ""
  vim.wo.signcolumn = "no"
  vim.opt.listchars = { space = " " }

  local buf = vim.api.nvim_get_current_buf()

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
	    lines[#lines] = nil
	  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  vim.api.nvim_chan_send(vim.api.nvim_open_term(buf, {}), table.concat(lines, "\r\n"))
  vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true, buffer = buf })
  vim.api.nvim_create_autocmd("TextChanged", { buffer = buf, command = "normal! G$" })
  vim.api.nvim_create_autocmd("TermEnter", { buffer = buf, command = "stopinsert" })
end
