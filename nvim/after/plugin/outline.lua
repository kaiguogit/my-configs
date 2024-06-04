vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
require("outline").setup({
    outline_window = {
        position = 'left',
        width = 15
    },
    preview_window = {
        auto_preview = true,
    }
})
