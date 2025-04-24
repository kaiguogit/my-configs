local mini_ai_git_signs = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local gitsigns_cache = require("gitsigns.cache").cache[bufnr]
  if not gitsigns_cache then
    return
  end
  local hunks = gitsigns_cache.hunks

  if not hunks then
    return
  end

  hunks = vim.tbl_map(function(hunk)
    local from_line = hunk.added.start
    local from_col = 1
    local to_line = hunk.vend
    local to_col = #vim.api.nvim_buf_get_lines(bufnr, to_line - 1, to_line, false)[1] + 1
    return {
      from = { line = from_line, col = from_col },
      to = { line = to_line, col = to_col },
    }
  end, hunks)

  return hunks
end

return {
  -- start copy from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua

  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      -- if type(opts.ensure_installed) == "table" then
      --   opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      -- end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      -- If treesitter is already loaded, we need to run config again for textobjects
      -- if LazyVim.is_loaded("nvim-treesitter") then
      --   local opts = LazyVim.opts("nvim-treesitter")
      --   require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      -- end

      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },
  -- end copy from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     "RRethy/nvim-treesitter-endwise",
  --     "chrisgrieser/nvim-puppeteer",
  --   },
  --   opts = {
  --     endwise = {
  --       enable = true,
  --     },
  --     tree_setter = {
  --       enable = true,
  --     },
  --     textobjects = {
  --       move = {
  --         enable = true,
  --         goto_next_start = { ["]r"] = "@return.outer" },
  --         goto_next_end = { ["]R"] = "@return.outer" },
  --         goto_previous_start = { ["[r"] = "@return.outer" },
  --         goto_previous_end = { ["[R"] = "@return.outer" },
  --       },
  --     },
  --   },
  -- },
  {
    "wellle/visual-split.vim",
  },
  {
    "aaronik/treewalker.nvim",
    lazy = false,

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",
    },

    keys = {
      -- movement
      { "<A-S-k>", "<cmd>Treewalker Up<cr>", mode = { "n", "x" } },
      { "<A-S-j>", "<cmd>Treewalker Down<cr>", mode = { "n", "x" } },
      { "<A-S-l>", "<cmd>Treewalker Right<cr>", mode = { "n", "x" } },
      { "<A-S-h>", "<cmd>Treewalker Left<cr>", mode = { "n", "x" } },

      -- swapping
      { "<C-S-j>", "<cmd>Treewalker SwapDown<cr>" },
      { "<C-S-k>", "<cmd>Treewalker SwapUp<cr>" },
      { "<C-S-l>", "<cmd>Treewalker SwapRight<CR>" },
      { "<C-S-h>", "<cmd>Treewalker SwapLeft<CR>" },
    },
  },
  {
    "nmac427/guess-indent.nvim",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "LunarWatcher/auto-pairs",
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "<leader>la", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy align" },
      { "<leader>lA", "<Plug>(LiveEasyAlign)", mode = { "n", "x" }, desc = "Live Easy align" },
    },
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {},
    keys = {
      { "<leader>j", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    -- event = "LazyFile",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close_on_slash = true, -- Auto close on trailing </
        },
      })
    end,
  },
  -- {
  --   "echasnovski/mini.ai",
  --   dependencies = {
  --     { "echasnovski/mini.extra", config = true },
  --   },
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local ai = require("mini.ai")
  --     local MiniExtra = require("mini.extra")
  --     return vim.tbl_deep_extend("force", opts, {
  --       custom_textobjects = {
  --         C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }),
  --         D = MiniExtra.gen_ai_spec.diagnostic(),
  --         E = MiniExtra.gen_ai_spec.diagnostic({ severity = vim.diagnostic.severity.ERROR }),
  --         h = mini_ai_git_signs,
  --         j = ai.gen_spec.treesitter({
  --           a = { "@jsx_attr" },
  --           i = { "@jsx_attr" },
  --         }),
  --         k = ai.gen_spec.treesitter({
  --           i = { "@assignment.lhs", "@key.inner" },
  --           a = { "@assignment.outer", "@key.inner" },
  --         }),
  --         L = MiniExtra.gen_ai_spec.line(),
  --         N = MiniExtra.gen_ai_spec.number(),
  --         O = ai.gen_spec.treesitter({
  --           a = { "@function.outer", "@class.outer" },
  --           i = { "@function.inner", "@class.inner" },
  --         }),
  --         -- mixes up with leap-spooky so not using it
  --         -- r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }),
  --         v = ai.gen_spec.treesitter({
  --           i = { "@assignment.rhs", "@value.inner", "@return.inner" },
  --           a = { "@assignment.outer", "@value.inner", "@return.outer" },
  --         }),
  --         ["$"] = ai.gen_spec.pair("$", "$", { type = "balanced" }),
  --       },
  --     })
  --   end,
  -- },
}
