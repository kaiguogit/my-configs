local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local opts = { noremap = true, silent = true }

ls.add_snippets(nil, {
    typescript = {
        snip({
            trig = "it",
            name = "jasmine test case",
            dscr = "Create a new test case",
        }, {
            text({ "it('" }),
            insert(1),
            text({ "', () => {" }),
            text({ "", "\t" }),
            insert(2),
            text({ "", "});" }),
            insert(0),
        }),
        snip({
            trig = "ait",
            name = "jasmine fakeAsync test case",
            dscr = "Create a new test fakeAsync case",
        }, {
            text({ "it('" }),
            insert(1),
            text({ "', fakeAsync(() => {" }),
            text({ "", "\t" }),
            insert(2),
            text({ "", "}));" }),
            insert(0),
        }),
    },
})
