-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.fuzzy-finder.fzf-lua" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.recipes.disable-tabline" },
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
}
