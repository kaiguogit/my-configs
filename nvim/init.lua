local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.g.mapleader = " "
require("plugins")

local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

-- remap default vim bindings
local opts = { silent = true , noremap=false }
local keymap = vim.api.nvim_set_keymap
 hop.setup {
--  keys = 'etovxqpdygfblzhckisuran'
  quit_key = '<SPC>',
  jump_on_sole_occurrence = false,

}
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

vim.keymap.set('', '<Leader>b', function()
  hop.hint_words()
end, {remap=true})

vim.keymap.set('', '<Leader>l', function()
  hop.hint_lines()
end, {remap=true})

