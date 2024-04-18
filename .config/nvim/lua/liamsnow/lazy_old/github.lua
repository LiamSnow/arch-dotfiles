return {
  {
    enabled = false,
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        palettes = {
          -- Custom duskfox with black background
          github_dark = {
            bg1 = '#000000', -- Black background
            bg0 = '#1d1d2b', -- Alt backgrounds (floats, statusline, ...)
            bg3 = '#121820', -- 55% darkened from stock
            sel0 = '#131b24', -- 55% darkened from stock
          },
        },
        specs = {
          all = {
            inactive = 'bg0', -- Default value for other styles
          },
          github_dark_dimmed = {
            inactive = '#090909', -- Slightly lighter then black background
          },
        },
        groups = {
          all = {
            NormalNC = { fg = 'fg1', bg = 'inactive' }, -- Non-current windows
          },
        },
      })

      vim.cmd('colorscheme github_dark_dimmed')
    end,
  }
}
