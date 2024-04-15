return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })

      vim.keymap.set('n', '<leader>n', ':NvimTreeOpen<CR>')
      vim.keymap.set('n', '<leader>m', ':NvimTreeClose<CR>')
    end
  }
}
