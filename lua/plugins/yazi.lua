return {
  "DreamMaoMao/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  keys = {
    { "<leader>y", "<cmd>Yazi<CR>", desc = "󰇥 Toggle Yazi" },
  },
}
