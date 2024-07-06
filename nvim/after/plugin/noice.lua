require("noice").setup({
views = {
    cmdline_popup = {
        position = {
            row = 25,
            col = "50%",
        },
        border = {
            style = "none",
            padding = { 2, 3 },
        },
        size = {
            width = 60,
            height = "auto",
        },
        win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
    },
    popupmenu = {
        relative = "editor",
        position = {
            row = 28,
            col = "50%",
        },
        size = {
            width = 60,
            height = 10,
        },
        border = {
            style = "none",
            padding = { 2, 3 },
        },
        win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
    },
},
routes = {
    {
        filter = {
            event = "msg_show",
            kind = "",
            find = "written",
        },
        opts = { skip = true },
    },
    {
        filter = {
            event = "lsp",
            kind = "progress",
            cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "lua_ls"
            end,
        },
        opts = { skip = true },
    },
},
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})