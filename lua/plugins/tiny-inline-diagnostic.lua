return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    -- Default configuration
    require("tiny-inline-diagnostic").setup {
      preset = "ghost", -- Can be: "modern", "classic", "minimal", "powerline", ghost", "simple", "nonerdfont", "amongus"
      options = {
        throttle = 0,
        softwrap = 50,
        multiple_diag_under_cursor = true,
        multilines = true,
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
        format = function(diagnostic)
          local message = diagnostic.message
          message = string.gsub(message, "%(", "\n(")
          message = string.gsub(message, "%)", ")\n")
          return message
        end,
      },
    }
    vim.diagnostic.config {
      virtual_text = false,
      virtual_lines = {
        -- only_current_line = true,
        highlight_whole_line = false,
      },
    }
  end,
}
