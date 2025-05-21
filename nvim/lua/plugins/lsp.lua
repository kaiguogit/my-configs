-- enabled if noice.nvim is off
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config or {}
	config.focus_id = ctx.method
	if not (result and result.contents) then
		return
	end
	local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
	if vim.tbl_isempty(markdown_lines) then
		return
	end
	return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

local LazyVimDiagnosticsIcons = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}
---@class lazyvim.util.lsp
local M = {}
---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}
---@param method string
---@param fn fun(client:vim.lsp.Client, buffer)
function M.on_supports_method(method, fn)
	M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })
	return vim.api.nvim_create_autocmd("User", {
		pattern = "LspSupportsMethod",
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.data.buffer ---@type number
			if client and method == args.data.method then
				return fn(client, buffer)
			end
		end,
	})
end

-- @opts table
-- @opts.command string
-- @opts.arguments table
-- @opts.on_result function
local function lsp_execute(opts)
	local clients = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })
	local vtsls_client = nil
	for _, client in ipairs(clients) do
		if client.name == "vtsls" then
			vtsls_client = client
			break
		end
	end

	if vtsls_client then
		local params = {
			command = opts.command,
			arguments = opts.arguments,
		}

		vtsls_client.request("workspace/executeCommand", params, function(err, result, ctx)
			if err then
				vim.notify("Error executing command: " .. vim.inspect(err), vim.log.levels.ERROR)
			else
				if opts.on_result ~= nil then
					opts.on_result(result)
				end
			end
		end)
	else
		vim.notify("vtsls client not found", vim.log.levels.WARN)
	end
end

-- @opts table
-- @opts.command string
-- @opts.arguments table
local function lsp_execute_to_qf(opts)
	lsp_execute({
		command = opts.command,
		arguments = opts.arguments,
		on_result = function(result)
			if result and #result > 0 then
				local qf_list = {}
				for _, item in ipairs(result) do
					table.insert(qf_list, {
						filename = vim.uri_to_fname(item.uri),
						lnum = item.range.start.line + 1,
						col = item.range.start.character + 1,
						text = item.lineText,
					})
				end
				vim.fn.setqflist(qf_list, "r")
				vim.cmd("copen")
				vim.notify("File references found and added to quickfix list", vim.log.levels.INFO)
			else
				vim.notify("No file references found", vim.log.levels.INFO)
			end
		end,
	})
end

local function lsp_action(action)
	vim.lsp.buf.code_action({
		apply = true,
		context = {
			only = { action },
			diagnostics = {},
		},
	})
end
return {
	-- start copy from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		-- event = "LazyFile",
		dependencies = {
			"mason.nvim",
			{
				"yioneko/nvim-vtsls",
				keys = {
					-- {
					-- 	"gd",
					-- 	function()
					-- 		local params = vim.lsp.util.make_position_params(0, "utf-8")
					--
					-- 		lsp_execute_to_qf({
					-- 			command = "typescript.goToTypeDefinition",
					-- 			arguments = {
					-- 				params.textDocument.uri,
					-- 				params.position,
					-- 			},
					-- 		})
					-- 	end,
					-- 	desc = "Goto Definition",
					-- },
					{
						"gd",
						function()
							require("vtsls").commands.goto_source_definition()
						end,
						desc = "Goto Source Definition",
					},
					-- {
					-- 	"gr",
					-- 	function()
					-- 		require("vtsls").commands.file_references()
					-- 	end,
					-- 	desc = "File References",
					-- },
					{
						"<leader>oi",
						function()
							require("vtsls").commands.organize_imports()
							-- lsp_action("source.organizeImports")
						end,
						desc = "Organize Imports",
					},
					-- {
					-- 	"<leader>cM",
					-- 	function()
					-- 		lsp_action("source.addMissingImports.ts")
					-- 	end,
					-- 	desc = "Add missing imports",
					-- },
					-- {
					-- 	"<leader>cu",
					-- 	function()
					-- 		lsp_action("source.removeUnused.ts")
					-- 	end,
					-- 	desc = "Remove unused imports",
					-- },
					-- {
					-- 	"<leader>cD",
					-- 	function()
					-- 		lsp_action("source.fixAll.ts")
					-- 	end,
					-- 	desc = "Fix all diagnostics",
					-- },
					-- {
					-- 	"<leader>cV",
					-- 	function()
					-- 		lsp_execute({ command = "typescript.selectTypeScriptVersion" })
					-- 	end,
					-- 	desc = "Select TS workspace version",
					-- },
					{
						"gl",
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })
							local vtsls_client = nil
							for _, client in ipairs(clients) do
								if client.name == "vtsls" then
									vtsls_client = client
									break
								end
							end

							if vtsls_client then
								local capabilities = vtsls_client.server_capabilities

								local lines = {}

								-- Add executeCommandProvider information
								table.insert(lines, "")
								table.insert(lines, "Execute Command Provider:")
								if capabilities.executeCommandProvider then
									local commands = capabilities.executeCommandProvider.commands
									if commands and #commands > 0 then
										table.insert(lines, "Supported commands:")
										for _, command in ipairs(commands) do
											table.insert(lines, "  - " .. command)
										end
									else
										table.insert(lines, "No specific commands listed")
									end
								else
									table.insert(lines, "Not supported by this LSP server")
								end

								table.insert(lines, "")
								table.insert(lines, "Code Action Provider:")
								if capabilities.codeActionProvider then
									local codeActionKinds = capabilities.codeActionProvider.codeActionKinds
									if codeActionKinds then
										for _, kind in ipairs(codeActionKinds) do
											table.insert(lines, "- " .. kind)
										end
									else
										table.insert(
											lines,
											"- All code actions are supported (no specific kinds listed)"
										)
									end
								end

								vim.lsp.util.open_floating_preview(lines, "markdown", { border = "single" })
							end
						end,
						desc = "Show supported LSP actions",
					},
				},
			},
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			---@class PluginLspOpts
			local ret = {
				-- options for vim.diagnostic.config()
				---@type vim.diagnostic.Opts
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
						-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
						-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
						-- prefix = "icons",
					},
					severity_sort = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = LazyVimDiagnosticsIcons.Error,
							[vim.diagnostic.severity.WARN] = LazyVimDiagnosticsIcons.Warn,
							[vim.diagnostic.severity.HINT] = LazyVimDiagnosticsIcons.Hint,
							[vim.diagnostic.severity.INFO] = LazyVimDiagnosticsIcons.Info,
						},
					},
				},
				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = true,
					exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
				},
				-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the code lenses.
				codelens = {
					enabled = false,
				},
				-- add any global capabilities here
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				-- LSP Server Settings
				---@type lspconfig.options
				servers = {
					lua_ls = {
						-- mason = false, -- set to false if you don't want this server to be installed with mason
						-- Use this to add any additional keymaps
						-- for specific lsp servers
						-- ---@type LazyKeysSpec[]
						-- keys = {},
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
					vtsls = {
						filetypes = {
							"javascript",
							"jsx",
							"tsx",
							"javascriptreact",
							"javascript.jsx",
							"typescript",
							"typescriptreact",
							"typescript.tsx",
						},
						settings = {
							complete_function_calls = false,
							vtsls = {
								enableMoveToFileCodeAction = true,
								autoUseWorkspaceTsdk = true,
								experimental = {
									completion = {
										enableServerSideFuzzyMatch = true,
									},
								},
							},
							typescript = {
								updateImportsOnFileMove = { enabled = "always" },
								suggest = {
									completeFunctionCalls = false,
								},
								tsserver = {
									maxTsServerMemory = 32000,
								},
								preferences = {
									includePackageJsonAutoImports = "on",
									preferTypeOnlyAutoImports = true,
								},
								inlayHints = {
									parameterNames = { enabled = "literals" },
									-- parameterTypes = { enabled = true },
									variableTypes = { enabled = true },
									propertyDeclarationTypes = { enabled = true },
									functionLikeReturnTypes = { enabled = true },
									enumMemberValues = { enabled = true },
								},
							},
						},
						root_dir = function()
							return vim.fn.getcwd()
						end,
					},
				},
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				-- @type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			}
			return ret
		end,
		---@param opts PluginLspOpts
		config = function(_, opts)
			-- setup autoformat
			-- LazyVim.format.register(LazyVim.lsp.formatter())

			-- setup keymaps
			-- LazyVim.lsp.on_attach(function(client, buffer)
			--   require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
			-- end)
			--
			-- LazyVim.lsp.setup()
			-- LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

			-- diagnostics signs
			if vim.fn.has("nvim-0.10.0") == 0 then
				if type(opts.diagnostics.signs) ~= "boolean" then
					for severity, icon in pairs(opts.diagnostics.signs.text) do
						local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
						name = "DiagnosticSign" .. name
						vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
					end
				end
			end

			vim.lsp.inlay_hint.enable(true)

			if vim.fn.has("nvim-0.10") == 1 then
				-- inlay hints
				if opts.inlay_hints.enabled then
					M.on_supports_method("textDocument/inlayHint", function(client, buffer)
						if
							vim.api.nvim_buf_is_valid(buffer)
							and vim.bo[buffer].buftype == ""
							and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
						then
							vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
						end
					end)
				end

				-- code lens
				if opts.codelens.enabled and vim.lsp.codelens then
					M.on_supports_method("textDocument/codeLens", function(client, buffer)
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = buffer,
							callback = vim.lsp.codelens.refresh,
						})
					end)
				end
			end

			-- This is for inline linting message
			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
				opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
					or function(diagnostic)
						local icons = LazyVimDiagnosticsIcons
						for d, icon in pairs(icons) do
							if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
								return icon
							end
						end
					end
			end
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available through mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end
			end

			if have_mason then
				mlsp.setup({
					ensure_installed = vim.tbl_deep_extend(
						"force",
						ensure_installed,
						{}
						-- LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
					),
					handlers = { setup },
				})
			end

			-- if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
			-- 	local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			-- 	LazyVim.lsp.disable("vtsls", is_deno)
			-- 	LazyVim.lsp.disable("denols", function(root_dir, config)
			-- 		if not is_deno(root_dir) then
			-- 			config.settings.deno.enable = false
			-- 		end
			-- 		return false
			-- 	end)
			-- end
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	-- end copy from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
	{ "onsails/lspkind.nvim" },
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
		},
	},
	{
		"aznhe21/actions-preview.nvim",
		event = "LspAttach",
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				-- opts = function()
				-- local keys = require("lazyvim.plugins.lsp.keymaps").get()
				--
				-- keys[#keys + 1] = { "<leader>ca", false }
				-- end,
			},
		},
		opts = {
			backend = { "snacks" },
			diff = {
				algorithm = "patience",
				ignore_whitespace = true,
			},
		},
		keys = {
			{
				"<leader>ca",
				function()
					require("actions-preview").code_actions()
				end,
				mode = { "n", "v" },
				desc = "Code Action Preview",
			},
		},
	},
	{
		"0oAstro/dim.lua",
		event = "LspAttach",
		opts = {
			disable_lsp_decorations = true,
		},
	},
}
