return {
  "rcarriga/nvim-notify",
  events = "BufRead",
  opts = {
    stages = "static",
    render = "compact",
    max_width = "30",
    fps = 5,
    level = 1,
    timeout = 1000,
    -- for transparent
    -- background_colour = "#000000",
  },
}
