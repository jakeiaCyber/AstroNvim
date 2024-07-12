return {
  {
    "goolord/alpha-nvim",
    enabled = false,
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "▄▄▄██▀▀▀ ▄▄▄       ██ ▄█▀▓█████  ██▓ ▄▄▄      ",
        "  ▒██   ▒████▄     ██▄█▒ ▓█   ▀ ▓██▒▒████▄    ",
        "  ░██   ▒██  ▀█▄  ▓███▄░ ▒███   ▒██▒▒██  ▀█▄  ",
        "▓██▄██▓  ░██▄▄▄▄██ ▓██ █▄ ▒▓█  ▄ ░██░░██▄▄▄▄██ ",
        " ▓███▒    ▓█   ▓██▒▒██▒ █▄░▒████▒░██░ ▓█   ▓██▒",
        " ▒▓▒▒░    ▒▒   ▓▒█░▒ ▒▒ ▓▒░░ ▒░ ░░▓   ▒▒   ▓▒█░",
        " ▒ ░▒░     ▒   ▒▒ ░░ ░▒ ▒░ ░ ░  ░ ▒ ░  ▒   ▒▒ ░",
        " ░ ░ ░     ░   ▒   ░ ░░ ░    ░    ▒ ░  ░   ▒   ",
        " ░   ░         ░  ░░  ░      ░  ░ ░        ░  ░",
      }
      return opts
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },
}
