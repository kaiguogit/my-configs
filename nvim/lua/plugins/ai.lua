return {
	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false,
	-- 	init = function()
	-- 		vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" })
	-- 		vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#03a598" })
	-- 	end,
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	lazy = false,
	-- 	opts = {
	-- 		model = "DeepSeek-V3-0324",
	-- 	},
	-- },
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for git operations
		},
		config = function()
			require("claude-code").setup({
				keymaps = {
					toggle = {
						normal = "<leader>ac", -- Normal mode keymap for toggling Claude Code, false to disable
						variants = {
							continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
							verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
						},
					},
					window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
					scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
				},
			})
		end,
	},
}
