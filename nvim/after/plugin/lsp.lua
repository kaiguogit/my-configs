local lsp_zero = require('lsp-zero')

local function organize_imports()
    local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ''
    }
    vim.lsp.buf.execute_command(params)
end
local function lsp_highlight_document(client)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]],
            false)
    end
end

lsp_zero.on_attach(function(client, bufnr)
    lsp_highlight_document(client);
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "ge", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    -- Used <leader>fr in telescope.lua
    -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>ph", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>oi", organize_imports)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'cssls',
        'html',
        'jsonls',
        'tsserver',
        'angularls',
        'rust_analyzer',
        'lua_ls',
        'clangd',
        'bashls'
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
