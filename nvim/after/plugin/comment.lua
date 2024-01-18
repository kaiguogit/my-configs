-- vim.keymap.set("n", "<C-_>", function() require('Comment.api').toggle.linewise.current() end,
-- { noremap = true, silent = true })
--
-- Toggle current line or with count
vim.keymap.set('n', '<C-_>', function()
    return vim.v.count == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })

-- Toggle in Op-pending mode
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise)')

-- -- Toggle in VISUAL mode
vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
