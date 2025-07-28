return {
{
		"otavioschwanck/arrow.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			show_icons = true,
			leader_key = ";",
			buffer_leader_key = "m",
			per_buffer_config = {
				sort_automatically = false
			}
		},
		-- Use ; for opening file list
		-- Use m for opening bookmark list
		config = function(_, opts)
			-- Delete m for bookmark because arrow.nvim use m
			if vim.fn.maparg('m', 'n') ~= '' then
				vim.keymap.del('n', 'm')
			end
			vim.keymap.set("n", "H", require("arrow.persist").previous)
			vim.keymap.set("n", "L", require("arrow.persist").next)
			vim.keymap.set("n", "<C-s>", require("arrow.persist").toggle)
			vim.keymap.set("n", "<M-h>", require("arrow.commands").commands.prev_buffer_bookmark)
			vim.keymap.set("n", "<M-l>", require("arrow.commands").commands.next_buffer_bookmark)
			vim.keymap.set("n", "M", require("arrow.commands").commands.toggle_current_line_for_buffer)
			require("arrow").setup(opts)
			-- Custom configuration or commands
		end,
	}
}
