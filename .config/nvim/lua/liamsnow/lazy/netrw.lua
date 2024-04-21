return {
  'prichrd/netrw.nvim',
  dependencies = { 'nvim-web-devicons' },
  config = function()
    require('netrw').setup({
      use_devicons = true,
    })
  end
}
