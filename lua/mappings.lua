require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<leader>m', ':Mason<CR>', { noremap = true, silent = true })
map('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true })

map('n', '<leader>n', ':enew<CR>', { noremap = true, silent = true, desc = 'Nuevo buffer' })
map('n', 'gb', '[{')  -- ir al inicio del bloque
map('n', 'gn', ']}')  -- ir al final del bloque0

-- NORMAL mode: Ctrl+Shift+J / K to move line down/up
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- VISUAL mode: Ctrl+Shift+J / K to move block down/up
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up", silent = true })

map("n", "<leader>pp", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format " })

