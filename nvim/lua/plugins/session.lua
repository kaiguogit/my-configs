return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      { "nvim-telescope/telescope.nvim", opt = true },
    },
    keys = {
      { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>sl", "<cmd>SessionSearch<CR>", desc = "List session" },
      { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/code", "~/Downloads", "/" },
      pre_save_cmds = {
        "tabdo Neotree close",
      },
      use_git_branch = true,
    },
  },
}
