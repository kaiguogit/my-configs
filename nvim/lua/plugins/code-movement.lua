return {
	{
		"smoka7/hop.nvim",
		version = "*", -- optional but strongly recommended
		config = function()
			local hop = require("hop")
			-- you can configure Hop the way you like here; see :h hop-config
			hop.setup({ keys = "asdfghjkl;qwertyuiop" })
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })

			vim.keymap.set("", "<C-h>", function()
				hop.hint_words()
			end, { remap = true })

			vim.keymap.set("", "<Leader>hl", function()
				hop.hint_lines()
			end, { remap = true })
		end,
	},
	-- auto comment lines with ctrl-/
	{
		"numToStr/Comment.nvim",
		-- lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"kkoomen/vim-doge",
		lazy = false,
		keys = {
        {
            "<leader>cg",
            function()
                vim.api.nvim_command("DogeGenerate")
            end,
            { desc = "doge generate" },
        },
     },
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	config = true,
	-- 	-- use opts = {} for passing setup options
	-- 	-- this is equivalent to setup({}) function
	-- },
	{ "ntpeters/vim-better-whitespace" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			-- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			-- for _, ls in ipairs(language_servers) do
			-- 	require("lspconfig")[ls].setup({
			-- 		capabilities = capabilities,
			-- 		-- you can add other fields for setting up lsp server in this table
			-- 	})
			-- end
			local more_msg_highlight = vim.api.nvim_get_hl_id_by_name("MoreMsg")
			local non_text_highlight = vim.api.nvim_get_hl_id_by_name("NonText")

			local ftMap = {
				vim = "indent",
				python = { "indent" },
				git = "",
			}

			require("ufo").setup({
				open_fold_hl_timeout = 150,
				fold_virt_text_handler = function(
					-- The start_line's text.
					virtual_text_chunks,
					-- Start and end lines of fold.
					start_line,
					end_line,
					-- Total text width.
					text_width,
					-- fun(str: string, width: number): string Trunctation function.
					truncate,
					-- Context for the fold.
					ctx
				)
					local line_delta = (" 󰁂 %d "):format(end_line - start_line)
					local remaining_width = text_width
						- vim.fn.strdisplaywidth(ctx.text)
						- vim.fn.strdisplaywidth(line_delta)
					table.insert(virtual_text_chunks, { line_delta, more_msg_highlight })
					local line = start_line
					while remaining_width > 0 and line < end_line do
						line = line + 1
						local line_text = vim.api.nvim_buf_get_lines(ctx.bufnr, line, line + 1, true)[1]
						line_text = " " .. vim.trim(line_text)
						local line_text_width = vim.fn.strdisplaywidth(line_text)
						if line_text_width <= remaining_width - 2 then
							remaining_width = remaining_width - line_text_width
						else
							line_text = truncate(line_text, remaining_width - 2) .. "…"
							remaining_width = remaining_width - vim.fn.strdisplaywidth(line_text)
						end
						table.insert(virtual_text_chunks, { line_text, non_text_highlight })
					end
					return virtual_text_chunks
				end,
				close_fold_kinds_for_ft = {
					default = { "imports", "comment" },
					json = { "array" },
					c = { "comment", "region" },
				},
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
				provider_selector = function(bufnr, filetype, buftype)
					-- if you prefer treesitter provider rather than lsp,
					-- return ftMap[filetype] or {'treesitter', 'indent'}
					return ftMap[filetype]

					-- refer to ./doc/example.lua for detail
				end,
			})
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					-- choose one of coc.nvim and nvim lsp
					-- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
					vim.lsp.buf.hover()
				end
			end)
			-- buffer scope handler
			-- -- will override global handler if it is existed
			-- local bufnr = vim.api.nvim_get_current_buf()
			-- require('ufo').setFoldVirtTextHandler(bufnr, handler)
		end,
	},
}
