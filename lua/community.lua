-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- ==========pack========
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  -- =========tool=========
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  { import = "astrocommunity.motion.flash-nvim" },
  -- { import = "astrocommunity.motion.before-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  -- { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.editing-support.bigfile-nvim" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.project.projectmgr-nvim" },
  -- { import = "astrocommunity.lsp.lsp-lens-nvim" },
  -- ========color=========
  -- { import = "astrocommunity.color.headlines-nvim" },
  -- { import = "astrocommunity.color.modes-nvim" },
}
