return {
  "rcarriga/nvim-notify",
  event = "BufRead",
  opts = {
    stages = "static",
    render = "compact",
    level = 1,
    timeout = 100,
  },
}
