vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          relativenumber = true,
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = math.floor(vim.o.columns * 0.8),
              height = math.floor(vim.o.lines * 0.8),
              row = math.floor(vim.o.lines * 0.1),
              col = math.floor(vim.o.columns * 0.1),
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              chars = "123456789"
            }
          }
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
