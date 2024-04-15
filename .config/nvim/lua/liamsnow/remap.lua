vim.g.mapleader = " "

-- Move Selection Up/Down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move Long Lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep Cursor In Middle When Jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep Cursor In Middle When Searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste Over Without Loosing Clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete Without Copy
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Yank to system clipboard (asbjornHaland)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Format Selection
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quick Fix List
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace Current Word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Chmod Bash
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

