return {
  "xzbdmw/colorful-menu.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    require("colorful-menu").setup {
      ls = {
        lua_ls = {
          arguments_hl = "@comment",
        },
        clangd = {
          extra_info_hl = "@comment",
        },
        fallback = true,
      },
      fallback_highlight = "@variable",
      max_width = 60,
    }
  end,
}
