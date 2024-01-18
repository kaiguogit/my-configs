require("neo-tree").setup({
    window = {
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
            ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
            ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
            ["o"] = "system_open",
        },
        commands = {
            system_open = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                -- macOs: open file in default application in the background.
                -- - vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
                --                 -- Linux: open file in default application
                vim.fn.jobstart({ "xdg-open", path }, { detach = true })
            end,
        },
    },
    filesystem = {
        hijack_netrw_behavior = "open_current",
        -- components = {
        -- harpoon_index = function(config, node, _)
        --     local harpoon_list = require("harpoon"):list()
        --     local path = node:get_id()
        --     local harpoon_key = vim.uv.cwd()

        --     for i, item in ipairs(harpoon_list.items) do
        --         local value = item.value
        --         print(value)
        --         if string.sub(item.value, 1, 1) ~= "/" then
        --             value = harpoon_key .. "/" .. item.value
        --         end

        --         if value == path then
        --             vim.print(path)
        --             return {
        --                 text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
        --                 highlight = config.highlight or "NeoTreeDirectoryIcon",
        --             }
        --         end
        --     end
        --     return {}
        -- end,
        --},
        -- renderers = {
        --     file = {
        --         { "icon" },
        --         { "name",         use_git_status_colors = true },
        --         { "harpoon_index" }, --> This is what actually adds the component in where you want it
        --         { "diagnostics" },
        --         { "git_status",   highlight = "NeoTreeDimText" },
        --     },
        -- },
    },
    buffers = {
        follow_current_file = {
            enabled = true,          -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
    },
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
                -- auto close
                -- vimc.cmd("Neotree close")
                -- OR
                require("neo-tree.command").execute({ action = "close" })
            end
        },
    }
})
