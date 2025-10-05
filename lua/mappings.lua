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
map("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
map("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- VISUAL mode: Ctrl+Shift+J / K to move block down/up
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down", silent = true })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up", silent = true })

map("n", "<leader>pp", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format " })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', 'gI', vim.lsp.buf.implementation, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    -- Añade más mapeos según necesites
  end,
})

-- Buscar la palabra bajo el cursor hacia abajo con ñ
map("n", "ñ", "*", { noremap = true, silent = true })
-- Buscar hacia arriba con Ñ (shift+ñ)
map("n", "Ñ", "#", { noremap = true, silent = true })

-- Navegar párrafos con ç y Ç
map("n", "ç", "}", { noremap = true, silent = true })  -- siguiente párrafo
map("n", "Ç", "{", { noremap = true, silent = true })  -- párrafo anterior

map("n", ",", "%", { desc = "Match bracket" })

map("n", "W", "$", { desc = "End of line" })
map("n", "B", "^", { desc = "Start of line" })

map("n", "-", "/", { desc = "Search" })

map("n", "gw", function()
  vim.diagnostic.goto_next()
end, { desc = "Go next diagnostic" })

map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
map("v", "<C-s>", "<Esc>:w<CR>gv", { desc = "Save file" })

map("n", "<leader>fg", function()
  require("spectre").open()
end, { desc = "Open Spectre" })


-- search current word
vim.keymap.set("n", "<leader>fw", function()
  require("spectre").open_file_search({ select_word = true })
end, { desc = "Search current word" })

-- search in current file
vim.keymap.set("n", "<leader>ff", function()
  require("spectre").open_file_search()
end, { desc = "Search in current file" })


map("n", "º", "~", { desc = "Toggle case" })
map("n", "¡", "\"", { desc = "Buffer" })

-- Normal mode
map("n", "M", "'", { desc = "Remap ' to M" })

-- Visual mode
map("v", "M", "'", { desc = "Remap ' to M" })

-- Operator-pending mode (ej: d', y', c')
map("o", "M", "'", { desc = "Remap ' to M" })


map("n", "<C-f>", function()
  print(vim.fn.expand("%:p"))
end, { desc = "Print full file path" })
