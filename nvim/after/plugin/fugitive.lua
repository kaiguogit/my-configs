local silentopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
vim.keymap.set("n", "<leader>gfh", ":G log --follow -p -20 -- %<CR>", silentopts)

vim.keymap.set('v', '<leader>gl', function()
    vim.print("G log -L" .. vim.fn.line('v') .. "," .. vim.fn.line('.') .. ":" .. vim.fn.expand('%:p'))
    vim.cmd("G log -L" .. vim.fn.line('v') .. "," .. vim.fn.line('.') .. ":" .. vim.fn.expand('%:p'))
end, {})
