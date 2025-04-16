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

local plugins = {
	-- Themes
	-- {"folke/tokyonight.nvim"},
	--
	-- {"bluz71/vim-nightfly-colors"},
    -- {
    --     "romanaverin/charleston.nvim",
    --     name = "charleston",
    --     priority = 1000,
    -- },
	-- {"flazz/vim-colorschemes"},
	{ "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000 },

	-- {"mhartington/oceanic-next" },
    -- multi line editing
    {"mg979/vim-visual-multi"},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.5",
		-- or                            , branch = '0.1.x',
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			-- Use telescope for nvim core selection such as lsp code action list.
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-hop.nvim" },
			{ "isak102/telescope-git-file-history.nvim" },
		},
	},

	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },

	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	-- harpoon2
	{"nvim-lua/plenary.nvim"},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
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
	},
	{'nvimtools/none-ls.nvim'},


	{
		"smoka7/hop.nvim",
		version = "*", -- optional but strongly recommended
		opts = {
			keys = 'etovxqpdygfblzhckisuran'
		}
	},

	-- auto comment lines with ctrl-/
	{"numToStr/Comment.nvim"},

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
	{"lewis6991/gitsigns.nvim"},
	{"0x00-ketsu/autosave.nvim"},

	 {"ntpeters/vim-better-whitespace" },

	-- shift+s to wrap selected text with quote or ()
	{ "tpope/vim-surround" },
	--  {
	-- "nvim-telescope/telescope-file-browser.nvim",
	-- dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	-- }
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
    -- disabled for performance
	-- ({ "lukas-reineke/indent-blankline.nvim" })

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	"onsails/lspkind.nvim",

	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua" },
			{ "nvim-telescope/telescope.nvim" },
		},
	},

	{"nvim-pack/nvim-spectre"},

	-- key hint
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#282A36",
			})
		end,
	},

	{
		"mrded/nvim-lsp-notify",
		config = function()
			require("lsp-notify").setup({
				notify = require("notify"),
			})
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
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
	},
	{ "mhartington/formatter.nvim" },

	{ "akinsho/toggleterm.nvim" },
	-- Press dd in quickfix list will delete current file
	{"TamaMcGlinn/quickfixdd"},
	-- For folding
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	-- Abstract methods and functions into overview.
	{ "hedyhli/outline.nvim" },
	-- Highlight usage of current word
	-- { "RRethy/vim-illuminate"} ,
    -- plugin for notification. disabled for performance
    -- https://github.com/LazyVim/LazyVim/discussions/326#discussioncomment-11454517
    -- ({"folke/noice.nvim",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    -- })
    {"m4xshen/hardtime.nvim",
        dependencies ={
            "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"
        }
    },
    -- Gdiff to send git lists to quickfix list
    {"oguzbilgic/vim-gdiff"},

    --  {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require("auto-session").setup {
    --             suppressed_dirs = { "/"},
    --         }
    --     end
    -- }

     {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }
    },
    {
        "gregorias/coerce.nvim",
        tag = 'v4.1.0',
        config = true,
    }
}

-- Setup lazy.nvim
require("lazy").setup({
  spec = plugins,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  change_detection = {
      notify = false
  }
})
