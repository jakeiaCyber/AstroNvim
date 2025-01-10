return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      debug = { enabled = true },
      indent = {
        indent = {
          char = " ",
          only_scope = true,
          only_current = true,
          hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
          },
        },
        animate = {
          duration = {
            step = 10,
            duration = 100,
          },
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "┋",
          underline = false, -- underline the start of the scope
          only_current = true, -- only show scope in the current window
          hl = {
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
          },
        },
      },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      dashboard = { example = "advanced" },
    },
  },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "NMAC427/guess-indent.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },
}
