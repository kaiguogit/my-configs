-- https://github.com/kapral18/dotfiles/tree/2defc515124671be6487a5e8bca4449df9707b4a/home/private_dot_config/exact_nvim
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local lazy = require("lazy")
-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Setup lazy.nvim
lazy.setup({
	rocks = { hererocks = true },
	spec = {
		-- -- add LazyVim and import its plugins
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- -- import any extras modules here
		-- { import = "lazyvim.plugins.extras.lang.python" },
		-- { import = "lazyvim.plugins.extras.lang.docker" },
		-- { import = "lazyvim.plugins.extras.lang.markdown" },
		-- { import = "lazyvim.plugins.extras.lang.rust" },
		-- { import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.lang.yaml" },
		-- { import = "lazyvim.plugins.extras.lang.go" },
		-- { import = "lazyvim.plugins.extras.editor.outline" },
		-- { import = "lazyvim.plugins.extras.editor.inc-rename" },
		-- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
		-- { import = "lazyvim.plugins.extras.dap.core" },
		-- { import = "lazyvim.plugins.extras.dap.nlua" },

		-- commented out already
		-- { import = "lazyvim.plugins.extras.editor.fzf" },
		-- { import = "lazyvim.plugins.extras.formatting.prettier" },
		-- { import = "lazyvim.plugins.extras.ui.treesitter-context" },
		-- { import = "lazyvim.plugins.extras.ai.copilot-chat" },
		-- { import = "plugins.open-eslint-path" },
		-- { import = "plugins.toggle-win-width" },
		-- { import = "plugins.ts-move-exports" },
		-- { import = "plugins.vtsls" },
		-- { import = "plugins.ai" },
		{ import = "plugins.bash" },
		-- { import = "plugins.bufferline" },
		{ import = "plugins.chezmoi" },
		{ import = "plugins.cmp" },
		-- { import = "plugins.code-movement" },
		{ import = "plugins.copy-to-qf" },
		{ import = "plugins.colorscheme" },
		-- { import = "plugins.dashboard" },
		{ import = "plugins.diff" },
		{ import = "plugins.disable-flash" },
		{ import = "plugins.eslint" },
		{ import = "plugins.explorer" },
		-- { import = "plugins.fish" },
		{ import = "plugins.fzf" },
		{ import = "plugins.git" },
		-- { import = "plugins.github" },
		{ import = "plugins.gx" },
		{ import = "plugins.harpoon" },
		{ import = "plugins.highlight" },
		{ import = "plugins.hlargs" },
		{ import = "plugins.html-css" },
		{ import = "plugins.jinja" },
		{ import = "plugins.jsonl" },
		{ import = "plugins.k8s" },
		{ import = "plugins.kdl" },
		{ import = "plugins.lazydev" },
		{ import = "plugins.leap" },
		{ import = "plugins.linting" },
		{ import = "plugins.log" },
		{ import = "plugins.lsp" },
		{ import = "plugins.lua" },
		{ import = "plugins.lualine" },
		{ import = "plugins.markdown" },
		{ import = "plugins.marks" },
		{ import = "plugins.multi-cursors" },
		{ import = "plugins.noice" },
		{ import = "plugins.numb" },
		{ import = "plugins.nvim-notify" },
		{ import = "plugins.osv" },
		{ import = "plugins.owner-code-search" },
		{ import = "plugins.parinfer" },
		{ import = "plugins.python" },
		{ import = "plugins.qf" },
		-- { import = "plugins.run-jest-in-split" },
		{ import = "plugins.rust" },
		{ import = "plugins.search-and-replace" },
		{ import = "plugins.session" },
		{ import = "plugins.show-file-owner" },
		-- { import = "plugins.snacks" },
		{ import = "plugins.summarize-code" },
		{ import = "plugins.summarize-commit" },
		{ import = "plugins.switch-src-test" },
		{ import = "plugins.tab" },
		-- { import = "plugins.tab-behavior" },
		-- { import = "plugins.telescope" },
		{ import = "plugins.tmux" },
		{ import = "plugins.toggle-term" },
		{ import = "plugins.tpope" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.trouble" },
		{ import = "plugins.typescript-tools" },
		{ import = "plugins.undotree" },
		{ import = "plugins.which-key" },
		{ import = "plugins.xml" },
		{ import = "plugins.yaml" },
		-- { import = "plugins.others" },
	},
	change_detection = { enabled = false, notify = false },
	concurrency = 100,
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioninG,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

