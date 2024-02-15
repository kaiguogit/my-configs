-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			-- Use telescope for nvim core selection such as lsp code action list.
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-hop.nvim" },
		},
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	-- harpoon2
	use("nvim-lua/plenary.nvim")
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			--- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	-- use('nvimtools/none-ls.nvim')

	use("flazz/vim-colorschemes")

	use({
		"smoka7/hop.nvim",
		tag = "*", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "asdfghjkl;qwertyuiop" })
		end,
	})

	-- auto comment lines with ctrl-/
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("lewis6991/gitsigns.nvim")

	use({
		"0x00-ketsu/autosave.nvim",
		config = function()
			require("autosave").setup({
				debounce_delay = 2000,
			})
		end,
	})
	-- Themes
	use("folke/tokyonight.nvim")
	use("bluz71/vim-nightfly-colors")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "mhartington/oceanic-next" })

	use({ "ntpeters/vim-better-whitespace" })

	-- shift+s to wrap selected text with quote or ()
	use({ "tpope/vim-surround" })
	-- use {
	-- "nvim-telescope/telescope-file-browser.nvim",
	-- requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	-- }
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	})
	use({ "lukas-reineke/indent-blankline.nvim" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"s1n7ax/nvim-window-picker",
		tag = "v2.*",
		config = function()
			require("window-picker").setup()
		end,
	})
	use("onsails/lspkind.nvim")

	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
	})

	use("nvim-pack/nvim-spectre")

	-- key hint
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#282A36",
			})
		end,
	})

	use({
		"mrded/nvim-lsp-notify",
		config = function()
			require("lsp-notify").setup({
				notify = require("notify"),
			})
		end,
	})
	use({
		"romgrk/barbar.nvim",
		requires = {
			{ "lewis6991/gitsigns.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("barbar").setup({
				icons = {
					pinned = { button = "", filename = true },
				},
			})
		end,
	})
	use({ "mhartington/formatter.nvim" })

	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
end)
