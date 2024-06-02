local silentopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
vim.keymap.set("n", "<leader>gfh", ":G log --follow -p -20 -- %<CR>", silentopts)
