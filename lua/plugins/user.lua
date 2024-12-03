---@type LazySpec
return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " 𝙔𝘼𝙔!ーーーーー",
        " ☆  *    .      ☆",
        "     . ∧＿∧    ∩    * ☆",
        "*  ☆ ( ・∀・)/ .",
        "  .  ⊂         ノ* ☆",
        "  ☆ * (つ ノ  .☆",
        "       (ノ",
      }
      return opts
    end,
  },
}
