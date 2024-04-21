return {
  'prichrd/netrw.nvim',
  dependencies = { 'nvim-web-devicons' },
  config = function()
    vim.g.netrw_browse_split = 0
    vim.g.netrw_banner = 0
    vim.g.netrw_winsize = 25

    require('netrw').setup({
      use_devicons = true,
    })
  end
}
