return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
        transparent_background = true,
        term_colors = true
      })
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
