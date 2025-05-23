require("toggleterm").setup({
    direction = 'float'
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-q>', [[<C-\><C-n><C-w>q]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>')
-- vim.keymap.set('n', '<leader>term', function()
    -- vim.print('123123')
    -- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
-- end)
