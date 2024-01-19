local actions = require "telescope.actions"
mappings = {
    i = {
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
    }
}
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                -- ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            previewer = false
        },
        git_files = {
            previewer = false
        },
        current_buffer_fuzzy_find = {
            previewer = false
        },
        buffers = {
            previewer = false,
        }
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        --
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            },

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            -- for example to disable the custom builtin "codeactions" display
            -- do the following
            -- codeactions = false,
            -- }
        },
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {         -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                },
            },
        }
    }
}

telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
vim.keymap.set('n', '<leader>gs', function()
    builtin.grep_string();
end)
vim.keymap.set('n', '<leader>cs', function()
    builtin.colorscheme()
end)

local function getCurrentFolderPath()
    return vim.fn.substitute(vim.fn.expand("%:p"), vim.fn.expand("%:t"), "", "")
end

-- Fuzzy search in current file
vim.keymap.set('n', '<leader>fgg', builtin.current_buffer_fuzzy_find, {})

-- Find all files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- Find files in current folder
vim.keymap.set('n', '<leader>ffd', function()
    builtin.find_files(
        {
            search_dirs = { getCurrentFolderPath() }
        }
    )
end)


-- live grep for all files
vim.keymap.set("n", "<leader>fg", function()
    telescope.extensions.live_grep_args.live_grep_args()
end)

-- live grep for current folder
vim.keymap.set("n", "<leader>fgd", function()
    telescope.extensions.live_grep_args.live_grep_args(
        {
            search_dirs = { getCurrentFolderPath() }
        }
    )
end)

-- live grep for current file
vim.keymap.set('n', '<C-f>', function()
    builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
