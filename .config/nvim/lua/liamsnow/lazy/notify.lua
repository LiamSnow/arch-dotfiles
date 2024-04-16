return {
  {
    enabled = false,
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact",
        stages = "static",
        background_colour = "#000000"
      })
    end
  }
}
