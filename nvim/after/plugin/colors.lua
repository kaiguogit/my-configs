
-- function ColorMyPencils(color)
-- 	color = color or "catppuccin-mocha"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        neotree = true,
        notify = true,
        barbar = true,
        harpoon = true,
        hop = true,
        mason = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        telescope = {
            enabled = true,
            -- style = "nvchad"
        },
        which_key = true
    }
})

require('lualine').setup({
    options = {
        theme = "catppuccin"
    }
})

vim.cmd.colorscheme("catppuccin-mocha")

-- vim.cmd.colorscheme("charleston")
--ColorMyPencils('tokyonight-moon');
-- ColorMyPencils('nightfly');
-- ColorMyPencils();
