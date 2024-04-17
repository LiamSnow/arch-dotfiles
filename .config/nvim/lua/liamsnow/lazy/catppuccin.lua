return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavor = "mocha",
        transparent_background = true,
        term_colors = true,
        highlight_overrides = {
          mocha = function(mocha)
            return {
              LineNr = { fg = mocha.overlay0 },
            }
          end
        },
        integrations = {
          cmp = true,
          nvimtree = true,
          treesitter = true,
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
