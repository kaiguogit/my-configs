local win_highlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None"
local kindsIcon =   {
  Array         = " ",
  Boolean       = "󰨙 ",
  Class         = " ",
  Codeium       = "󰘦 ",
  Color         = " ",
  Control       = " ",
  Collapsed     = " ",
  Constant      = "󰏿 ",
  Constructor   = " ",
  Copilot       = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "󰊕 ",
  Interface     = " ",
  Key           = " ",
  Keyword       = " ",
  Method        = "󰊕 ",
  Module        = " ",
  Namespace     = "󰦮 ",
  Null          = " ",
  Number        = "󰎠 ",
  Object        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = "󱄽 ",
  String        = " ",
  Struct        = "󰆼 ",
  Supermaven    = " ",
  TabNine       = "󰏚 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = "󰀫 ",
}
-- copied from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/util/cmp.lua
-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
local function cmp_confirm(opts)
  local cmp = require("cmp")
  opts = vim.tbl_extend("force", {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})
  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      -- LazyVim.create_undo()
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end
-- Native Snippets
local function snippet_forward()
  if vim.snippet.active({ direction = 1 }) then
    vim.schedule(function()
      vim.snippet.jump(1)
    end)
    return true
  end
end

return {
  {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 250,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },

            list = {
              selection = {
                preselect = function(ctx)
                  return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                end,
              }
            },

            menu = {
                border = "rounded",

                cmdline_position = function()
                    if vim.g.ui_cmdline_pos ~= nil then
                        local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                        return { pos[1] - 1, pos[2] }
                    end
                    local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                    return { vim.o.lines - height, 0 }
                end,

                draw = {
                    columns = {
                        { "kind_icon", "label", gap = 1 },
                        { "kind" },
                    },
                    components = {
                        kind_icon = {
                            text = function(item)
                                local kind = require("lspkind").symbol_map[item.kind] or ""
                                return kind .. " "
                            end,
                            highlight = "CmpItemKind",
                        },
                        label = {
                            text = function(item)
                                return item.label
                            end,
                            highlight = "CmpItemAbbr",
                        },
                        kind = {
                            text = function(item)
                                return item.kind
                            end,
                            highlight = "CmpItemKind",
                        },
                    },
                },
            },
        },

        -- My super-TAB configuration
        keymap = {
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },

            ["<Tab>"] = {
                function(cmp)
                    return cmp.select_next()
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    return cmp.select_prev()
                end,
                "snippet_backward",
                "fallback",
            },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-up>"] = { "scroll_documentation_up", "fallback" },
            ["<C-down>"] = { "scroll_documentation_down", "fallback" },
        },

        -- Experimental signature help support
        signature = {
            enabled = true,
            window = { border = "rounded" },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            -- cmdline = {}, -- Disable sources for command-line mode
            -- providers = {
            --     lsp = {
            --         -- min_keyword_length = 2, -- Number of characters to trigger porvider
            --         score_offset = 0, -- Boost/penalize the score of the items
            --     },
            --     path = {
            --         min_keyword_length = 0,
            --     },
            --     snippets = {
            --         min_keyword_length = 2,
            --     },
            --     buffer = {
            --         min_keyword_length = 5,
            --         max_items = 5,
            --     },
            -- },
        },
    },
  },
-- {
--   'saghen/blink.cmp',
--   -- optional: provides snippets for the snippet source
--   dependencies = { 'rafamadriz/friendly-snippets' },
--
--   -- use a release tag to download pre-built binaries
--   version = '1.*',
--   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--   -- build = 'cargo build --release',
--   -- If you use nix, you can build from source using latest nightly rust with:
--   -- build = 'nix run .#build-plugin',
--
--   ---@module 'blink.cmp'
--   ---@type blink.cmp.Config
--   opts = {
--     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
--     -- 'super-tab' for mappings similar to vscode (tab to accept)
--     -- 'enter' for enter to accept
--     -- 'none' for no mappings
--     --
--     -- All presets have the following mappings:
--     -- C-space: Open menu or open docs if already open
--     -- C-n/C-p or Up/Down: Select next/previous item
--     -- C-e: Hide menu
--     -- C-k: Toggle signature help (if signature.enabled = true)
--     --
--     -- See :h blink-cmp-config-keymap for defining your own keymap
--     keymap = {
--         preset = 'default',
--         ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
-- ['<C-e>'] = { 'hide' },
-- ['<C-y>'] = { 'select_and_accept' },
--
-- ['<Up>'] = { 'select_prev', 'fallback' },
-- ['<Down>'] = { 'select_next', 'fallback' },
-- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
-- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
--
-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
-- ['<Tab>'] = { 'snippet_forward', 'fallback' },
-- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
-- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
--       },
--
--     appearance = {
--       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--       -- Adjusts spacing to ensure icons are aligned
--       nerd_font_variant = 'mono'
--     },
--
--     -- (Default) Only show the documentation popup when manually triggered
--     completion = { documentation = { auto_show = false }  },
--
--     -- Default list of enabled providers defined so that you can extend it
--     -- elsewhere in your config, without redefining it, due to `opts_extend`
--     sources = {
--       default = { 'lsp', 'path', 'snippets', 'buffer' },
--     },
--
--     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
--     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
--     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
--     --
--     -- See the fuzzy documentation for more information
--     fuzzy = { implementation = "prefer_rust_with_warning" }
--   },
--   opts_extend = { "sources.default" }
-- }
  -- start copy from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/extras/coding/nvim-cmp.lua#L11
   -- Setup nvim-cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --   },
  --   -- Not all LSP servers add brackets when completing a function.
  --   -- To better deal with this, LazyVim adds a custom option to cmp,
  --   -- that you can configure. For example:
  --   --
  --   -- ```lua
  --   -- opts = {
  --   --   auto_brackets = { "python" }
  --   -- }
  --   -- ```
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     local auto_select = true
  --     return {
  --       auto_brackets = {}, -- configure any filetype to auto add brackets
  --       completion = {
  --         completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
  --       },
  --       preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<CR>"] = cmp_confirm({ select = auto_select }),
  --         ["<C-y>"] = cmp_confirm({ select = true }),
  --         ["<S-CR>"] = cmp_confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --         ["<tab>"] = snippet_forward
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "lazydev" },
  --         { name = "nvim_lsp" },
  --         { name = "path" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --       formatting = {
  --         format = function(entry, item)
  --           local icons = kindsIcon
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --
  --           local widths = {
  --             abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --             menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --           }
  --
  --           for key, width in pairs(widths) do
  --             if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --               item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
  --             end
  --           end
  --
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         -- only show ghost text when we show ai completions
  --         ghost_text = vim.g.ai_cmp and {
  --           hl_group = "CmpGhostText",
  --         } or false,
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  -- },
  -- end copy from https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/plugins/extras/coding/nvim-cmp.lua#L11
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     { "hrsh7th/cmp-nvim-lsp-signature-help" },
  --     { "hrsh7th/cmp-cmdline" },
  --     {
  --       "rcarriga/cmp-dap",
  --       dependencies = {
  --         { "mfussenegger/nvim-dap" },
  --       },
  --     },
  --     { "lukas-reineke/cmp-rg" },
  --     { "lukas-reineke/cmp-under-comparator" },
  --     { "SergioRibera/cmp-dotenv" },
  --     { "hrsh7th/cmp-emoji" },
  --     { "amarakon/nvim-cmp-fonts" },
  --   },
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, { name = "nvim_lsp_signature_help" })
  --     table.insert(opts.sources, { name = "rg", keyword_length = 3 })
  --     opts.sorting = opts.sorting or {}
  --     opts.sorting.comparators = opts.sorting.comparators or {}
  --     table.insert(opts.sorting.comparators, 4, require("cmp-under-comparator").under)
  --     table.insert(opts.sources, { name = "dotenv" })
  --     table.insert(opts.sources, { name = "emoji" })
  --     table.insert(opts.sources, { name = "fonts", option = { space_filter = "-" } })
  --
  --     opts.window = {
  --       completion = {
  --         border = "rounded",
  --         winhighlight = win_highlight,
  --       },
  --       documentation = {
  --         border = "rounded",
  --         winhighlight = win_highlight,
  --       },
  --     }
  --
  --     cmp.setup.filetype({ "dap-repl" }, {
  --       sources = {
  --         { name = "dap" },
  --       },
  --     })
  --
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         { name = "cmdline" },
  --       }),
  --     })
  --   end,
  -- },
}
