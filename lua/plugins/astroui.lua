-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- colorscheme = "vscode",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
        -- Python
        ["@none.python"] = { fg = "#c678dd" },
        ["@variable.python"] = { fg = "#e06c75" },
        ["@variable.parameter.python"] = { fg = "#e06c75" },
        ["@operator.python"] = { fg = "#56b6c2" },
        ["@function.call.python"] = { fg = "#61afef" },
        ["@lsp.type.function.python"] = { fg = "#61afef" },
        ["@function.builtin.python"] = { fg = "#61afef" },
        ["@lsp.typemod.function.defaultLibrary.python"] = { fg = "#61afef" },
        ["@boolean.python"] = { fg = "#d19a66" },
        ["@string.escape.python"] = { fg = "#56b6c2" },
        ["@lsp.type.parameter.python"] = { fg = "#e06c75" },
        ["@type.python"] = { fg = "#abb2bf" },
        ["@constant.builtin.python"] = { fg = "#d19a66" },
        ["@constructor.python"] = { fg = "#61afef" },
        ["@lsp.type.typeParameter.python"] = { fg = "#e06c75" },
        ["@lsp.type.type.python"] = { fg = "#e5c06b" },
        ["@function.method.python"] = { fg = "#56b6c2" },
        ["@lsp.typemod.method.definition.python"] = { fg = "#56b6c2" },
        ["@variable.builtin.python"] = { fg = "#e5c06b" },
        ["@variable.member.python"] = { fg = "#e06c75" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
