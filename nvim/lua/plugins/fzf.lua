local common_utils = require("utils.common")

local function open_file(selected, opts)
	common_utils.open_image(selected[1], function()
		require("fzf-lua.actions").file_edit(selected, opts)
	end)
end

local function get_fzf_fn(cmd, opts)
	opts = opts or {}
	return function()
		require("fzf-lua")[cmd](opts)
	end
end

local function get_telescope_fn(cmd, opts)
	opts = opts or {}
	return function()
		require("telescope.builtin")[cmd](opts)
	end
end

local function live_grep_with_patterns(initial_search, opts)
	local search_patterns = {
		initial_search,
		[[\b]]
			.. initial_search
			.. [[\b -- **/*.ts **/*.tsx !*.d.ts !*.test.ts !*.test.tsx !**/__mocks__/* !**/__jest__/* !**/fixtures/* !**/test/* !**/mock/*]],
		[[\b]] .. initial_search .. [[\b -- **/*.ts **/*.tsx !*.d.ts]],
	}
	local current_index = 1

	local function cycle_current_index()
		current_index = (current_index % #search_patterns) + 1
	end

	local function nested_live_grep()
		require("fzf-lua").live_grep(vim.tbl_deep_extend("force", {
			rg_glob = true,
			no_esc = true,
			actions = {
				["ctrl-g"] = { nested_live_grep }, -- No need to pass rg_opts here
			},
			search = search_patterns[current_index],
			["keymap.fzf.start"] = "beginning-of-line+forward-char+forward-char",
		}, opts))

		cycle_current_index()
	end

	nested_live_grep()
end

local function open(command, opts)
	opts = opts or {}
	if opts.cmd == nil and command == "git_files" and opts.show_untracked then
		opts.cmd = "git ls-files --exclude-standard --cached --others"
	end
	return require("fzf-lua")[command](opts)
end
local function on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

-- falllback to find_files if it's not a git folder
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}
return {
	-- start copy from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/extras/editor/fzf.lua#L45
	{
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local config = fzf.config
      local actions = fzf.actions

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
      config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
      config.defaults.keymap.builtin["<c-h>"] = "toggle-help"

      -- -- Trouble
      -- if LazyVim.has("trouble.nvim") then
      --   config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
      -- end

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.root = o.root == false
        o.cwd = nil
        o.buf = ctx.__CTX.bufnr
        open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return {
        "default-title",
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          -- formatter = "path.filename_first",
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },
        -- Custom LazyVim option to configure vim.ui.select
        ui_select = function(fzf_opts, items)
          return vim.tbl_deep_extend("force", fzf_opts, {
            prompt = " ",
            winopts = {
              title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
              title_pos = "center",
            },
          }, fzf_opts.kind == "codeaction" and {
            winopts = {
              layout = "vertical",
              -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
              width = 0.5,
              preview = {
                layout = "vertical",
                vertical = "down:15,border-top",
              },
            },
          } or {
            winopts = {
              width = 0.5,
              -- height is number of items, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
            },
          })
        end,
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      }
    end,
    config = function(_, opts)
      if opts[1] == "default-title" then
        -- use the same prompt for all pickers for profile `default-title` and
        -- profiles that use `default-title` as base profile
        local function fix(t)
          t.prompt = t.prompt ~= nil and " " or nil
          for _, v in pairs(t) do
            if type(v) == "table" then
              fix(v)
            end
          end
          return t
        end
        opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
        opts[1] = nil
      end
      require("fzf-lua").setup(opts)
    end,
    init = function()
      on_very_lazy(function()
        vim.ui.select = function(...)
          require("lazy").load({ plugins = { "fzf-lua" } })
          local opts = {}
          require("fzf-lua").register_ui_select(opts.ui_select or nil)
          return vim.ui.select(...)
        end
      end)
    end,
    keys = {
      -- { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      -- { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
      -- find
      { "<C-M-l>", function() open("live_grep") end, desc = "Grep (Root Dir)" },
      { "<M-S-l>", function() open("live_grep", { root = false })end, desc = "Grep (cwd)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<C-M-p>", function() 
				local cwd = vim.fn.getcwd()
				if is_inside_work_tree[cwd] == nil then
					vim.fn.system("git rev-parse --is-inside-work-tree")
					is_inside_work_tree[cwd] = vim.v.shell_error == 0
				end

				if is_inside_work_tree[cwd] then
					require("fzf-lua").git_files({preview_opts = {hidden = true}})
				else
					open("files", {preview_opts = {hidden = true}})
				end
      end, desc = "Find Files (Root Dir)" },
      { "<C-p>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<M-S-p>", function() open("files", { root = false })end, desc = "Find Files (cwd)" },
      { "<C-M-f>", function() open("grep_cword")end, desc = "Word (Root Dir)" },
      { "<C-M-f>", 
        function() open("grep_visual")end,
        mode = "v",
        desc = "Selection (Root Dir)" },
      { "<M-S-f>", function() open("grep_cword", { root = false })end, desc = "Word (cwd)" },
      { "<M-S-f>", function() open("grep_visual", { root = false })end, mode = "v", desc = "Selection (cwd)" },
      -- { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      -- { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      -- { "<leader>fR", function() open("oldfiles", { cwd = vim.uv.cwd() })end, desc = "Recent (cwd)" },
      -- git
      -- { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      -- { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      -- { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      -- { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<C-f>", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      -- { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      -- { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      -- { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      -- { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      -- { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>kp", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      -- { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      -- { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      -- { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      -- { "<leader>uC", function() open("colorschemes")end, desc = "Colorscheme with Preview" },
      -- {
      --   "<leader>ss",
      --   function()
      --     require("fzf-lua").lsp_document_symbols({
      --       regex_filter = symbols_filter,
      --     })
      --   end,
      --   desc = "Goto Symbol",
      -- },
      -- {
      --   "<leader>sS",
      --   function()
      --     require("fzf-lua").lsp_live_workspace_symbols({
      --       regex_filter = symbols_filter,
      --     })
      --   end,
      --   desc = "Goto Symbol (Workspace)",
      -- },
    },
  },

  -- {
  --   "folke/todo-comments.nvim",
  --   optional = true,
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>st", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
  --     { "<leader>sT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
  --   },
  -- },

	-- end copy from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/extras/editor/fzf.lua#L45
	-- {
	-- 	"ibhagwan/fzf-lua",
	-- 	dependencies = {
	-- 		{ "nvim-tree/nvim-web-devicons" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 		{
	-- 			"leath-dub/snipe.nvim",
	-- 			opts = {
	-- 				navigate = {
	-- 					cancel_snipe = "q",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>,",
	-- 			false,
	-- 		},
	-- 		{
	-- 			"<leader>sb",
	-- 			function()
	-- 				require("snipe").open_buffer_menu()
	-- 			end,
	-- 			desc = "Open Snipe buffer menu",
	-- 		},
	-- 		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	-- 		{
	-- 			"<leader><space>",
	-- 			get_fzf_fn("files", {
	-- 				cwd = vim.uv.cwd(),
	-- 			}),
	-- 			desc = "Files",
	-- 		},
	-- 		{
	-- 			"<leader>i",
	-- 			get_fzf_fn("files", {
	-- 				cwd = vim.uv.cwd(),
	-- 			}),
	-- 			desc = "Files",
	-- 		},
	-- 		{ "<leader>fr", get_fzf_fn("oldfiles", {
	-- 			cwd = vim.uv.cwd(),
	-- 		}), desc = "Recent (cwd)" },
	-- 		{ "<leader>fr", get_telescope_fn("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
	-- 		{ "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent (all)" },
	-- 		{
	-- 			"<leader>/",
	-- 			get_fzf_fn("lgrep_curbuf"),
	-- 			desc = "Grep",
	-- 		},
	-- 		{
	-- 			"<leader>sg",
	-- 			function()
	-- 				live_grep_with_patterns("", { cwd = vim.uv.cwd() })
	-- 			end,
	-- 			desc = "Live Grep",
	-- 		},
	-- 		{
	-- 			"<leader>sG",
	-- 			function()
	-- 				live_grep_with_patterns("", { cwd = vim.uv.cwd() })
	-- 			end,
	-- 			desc = "Live Grep (+ ignored)",
	-- 		},
	-- 		{
	-- 			"<leader>sR",
	-- 			get_fzf_fn("resume"),
	-- 			desc = "Resume Picker List",
	-- 		},
	-- 		{
	-- 			"<m-s-f>",
	-- 			function()
	-- 				live_grep_with_patterns(vim.fn.expand("<cword>"), {
	-- 					cwd = vim.uv.cwd(),
	-- 				})
	-- 			end,
	-- 			desc = "Live Grep CWord current folder",
	-- 		},
	-- 		-- {
	-- 		-- 	"<leader>sW",
	-- 		-- 	function()
	-- 		-- 		live_grep_with_patterns(vim.fn.expand("<cword>"), {
	-- 		-- 			cwd = vim.uv.cwd(),
	-- 		-- 		})
	-- 		-- 	end,
	-- 		-- 	desc = "Live Grep CWord (+ ignored)",
	-- 		-- },
	-- 		{
	-- 			"<m-s-f>",
	-- 			function()
	-- 				live_grep_with_patterns(vim.trim(require("fzf-lua").utils.get_visual_selection()), {
	-- 					no_esc = false,
	-- 					cwd = vim.uv.cwd(),
	-- 				})
	-- 			end,
	-- 			mode = "v",
	-- 			desc = "Live Grep Selection current folder",
	-- 		},
	-- 		-- {
	-- 		-- 	"<leader>sW",
	-- 		-- 	function()
	-- 		-- 		live_grep_with_patterns(vim.trim(require("fzf-lua").utils.get_visual_selection()), {
	-- 		-- 			no_esc = false,
	-- 		-- 			cwd = vim.uv.cwd(),
	-- 		-- 		})
	-- 		-- 	end,
	-- 		-- 	mode = "v",
	-- 		-- 	desc = "Live Grep Selection (+ignored)",
	-- 		-- },
	-- 	},
	-- 	opts = function()
	-- 		local actions = require("fzf-lua").actions
	-- 		return {
	-- 			defaults = {
	-- 				git_icons = false,
	-- 				file_icons = false,
	-- 			},
	-- 			winopts = {
	-- 				height = 0.50,
	-- 				width = 0.75,
	-- 				fullscreen = true,
	-- 				preview = {
	-- 					default = "builtin",
	-- 					border = "noborder",
	-- 					wrap = "wrap",
	-- 					layout = "vertical",
	-- 					vertical = "up:75%",
	-- 					scrollbar = false,
	-- 					scrollchars = { "", "" },
	-- 					winopts = {
	-- 						number = false,
	-- 						relativenumber = false,
	-- 					},
	-- 				},
	-- 			},
	-- 			keymap = {
	-- 				fzf = {
	-- 					["down"] = "down",
	-- 					["up"] = "up",
	-- 					["ctrl-c"] = "abort",
	-- 					["ctrl-a"] = "toggle-all",
	-- 					["ctrl-q"] = "select-all+accept",
	-- 					["ctrl-d"] = "preview-page-down",
	-- 					["ctrl-u"] = "preview-page-up",
	-- 				},
	-- 			},
	-- 			fzf_opts = {
	-- 				["--prompt"] = "  ",
	-- 				["--keep-right"] = false,
	-- 				["--preview"] = "bat --style=numbers --line-range :300 --color always {}",
	-- 			},
	-- 			previewers = {
	-- 				-- bat = {
	-- 				-- 	cmd = "bat-preview",
	-- 				-- 	-- set a bat theme, `bat --list-themes`
	-- 				-- 	theme = "Catppuccin-mocha",
	-- 				-- },
	-- 			},
	-- 			files = {
	-- 				previewer = "bat",
	-- 				prompt = "Files❯ ",
	-- 				fzf_opts = { ["--ansi"] = false },
	-- 				actions = {
	-- 					["default"] = open_file,
	-- 					["enter"] = open_file,
	-- 					["ctrl-q"] = actions.file_sel_to_qf,
	-- 					["ctrl-y"] = function(selected)
	-- 						common_utils.copy_to_clipboard(selected[1])
	-- 					end,
	-- 					-- we don't need alt-i, as it's covered by ctrl-g
	-- 					["alt-h"] = { actions.toggle_hidden },
	-- 				},
	-- 			},
	-- 			grep = {
	-- 				previewer = "bat",
	-- 				prompt = "Live Grep❯ ",
	-- 				input_prompt = "Grep❯ ",
	-- 				actions = {
	-- 					["ctrl-q"] = actions.file_sel_to_qf,
	-- 					["ctrl-y"] = function(selected)
	-- 						common_utils.copy_to_clipboard(selected[1])
	-- 					end,
	-- 					-- we need alt-i as ctrl-g is used for cycling search patterns
	-- 					["alt-i"] = { actions.toggle_ignore },
	-- 					["alt-h"] = { actions.toggle_hidden },
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- },
}
