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
