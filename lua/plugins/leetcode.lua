---@type LazySpec
return {
  "kawre/leetcode.nvim",
  cmd = "Leet",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/plenary.nvim" }, -- required by telescope
    { "MunifTanjim/nui.nvim" },

    -- optional
    { "rcarriga/nvim-notify", optional = true },
    { "nvim-tree/nvim-web-devicons", optional = true },
    {
      "nvim-treesitter/nvim-treesitter",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "html" })
        end
      end,
    },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        autocmds = {
          leetcode_autostart = {
            {
              event = "VimEnter",
              desc = "Start leetcode.nvim on startup",
              nested = true,
              callback = function()
                if vim.fn.argc() ~= 1 then return end -- return if more than one argument given
                local arg = vim.tbl_get(require("astrocore").plugin_opts "leetcode.nvim", "arg") or "leetcode.nvim"
                if vim.fn.argv()[1] ~= arg then return end -- return if argument doesn't match trigger
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
                if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return end -- return if buffer is non-empty
                require("leetcode").start(true)
              end,
            },
          },
        },
      },
    },
  },
  opts = {
    cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    },
    injector = { ---@type table<lc.lang, lc.inject>
      ["cpp"] = {
        before = {
          "using namespace std;",
          "#include <algorithm>",
          "#include <array>",
          "#include <bitset>",
          "#include <climits>",
          "#include <deque>",
          "#include <functional>",
          "#include <iostream>",
          "#include <list>",
          "#include <queue>",
          "#include <stack>",
          "#include <tuple>",
          "#include <unordered_map>",
          "#include <unordered_set>",
          "#include <utility>",
          "#include <vector>",
        },
      },
    },
    ---@type lc.storage
    storage = {
      -- home = vim.fn.stdpath "data" .. "/leetcode",
      home = "/Users/aizhongbo/workspace/codes/leetcode",
      cache = vim.fn.stdpath "cache" .. "/leetcode",
    },
  },
}
