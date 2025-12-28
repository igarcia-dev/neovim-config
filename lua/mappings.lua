require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<leader>m', ':Mason<CR>', { noremap = true, silent = true })
map('n', '<leader>l', ':Lazy<CR>', { noremap = true, silent = true })

map('n', '<leader>n', ':enew<CR>', { noremap = true, silent = true, desc = 'Nuevo buffer' })
map('n', 'gi', '[{')  -- ir al inicio del bloque
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
map("o", "-", "/", { desc = "Search motion" })

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


map("n", "º", "\"", { desc = "Register" })

-- Normal mode
map("n", "M", "m", { desc = "Set mark" })
map("n", "mm", "``", { desc = "Jump to last position" })
map("n", "m", "'", { desc = "Go to mark" })

-- Visual mode
map("v", "M", "m", { desc = "Set mark" })
map("v", "m", "'", { desc = "Go to mark" })

-- Operator-pending mode (ej: d', y', c')
map("o", "m", "'", { desc = "Go to mark" })


map("n", "<C-f>", function()
  print(vim.fn.expand("%:p"))
end, { desc = "Print full file path" })


map("n", "gb", function()
  local line = vim.fn.line(".")
  local file = vim.fn.expand("%:p")

  -- Ejecuta git blame para esa línea y captura la salida
  local result = vim.fn.system(
    string.format("git blame -L %d,%d --line-porcelain %s", line, line, file)
  )

  if vim.v.shell_error ~= 0 or result == "" then
    vim.notify("git blame failed for this line", vim.log.levels.ERROR, { title = "Git blame" })
    return
  end

  local author = result:match("author (.-)\n") or "unknown"
  local date   = result:match("author%-time (%d+)\n")

  if date then
    date = os.date("%Y-%m-%d %H:%M:%S", tonumber(date))
  else
    date = "unknown"
  end

  local msg = string.format("Blame → %s @ %s (line %d)", author, date, line)
  vim.notify(msg, vim.log.levels.INFO, { title = "Git blame" })
end, { desc = "Show git blame of current line" })


-- Open current file in Typora in background
map("n", "<C-t>", function()
  local current_file = vim.fn.expand("%:p")
  vim.fn.jobstart({"typora", current_file}, {detach = true})
end, { desc = "Open current file in Typora" })


map("n", "gs", function()
  local line = vim.fn.line(".")
  local file = vim.fn.expand("%:p")

  -- 1) Sacar el SHA de la línea actual
  local blame = vim.fn.system(
    string.format("git blame -L %d,%d --line-porcelain %s", line, line, file)
  )

  if vim.v.shell_error ~= 0 or blame == "" then
    vim.notify("git blame failed", vim.log.levels.ERROR, { title = "Git show" })
    return
  end

  local sha = blame:match("^(%w+)")
  if not sha then
    vim.notify("No SHA found in blame output", vim.log.levels.ERROR, { title = "Git show" })
    return
  end

  -- 2) Abrir split con buffer NUEVO (sin tocar el actual)
  vim.cmd("botright split")
  vim.cmd("enew")
  vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")

  -- 3) Ejecutar git show y volcarlo en el buffer
  local output = vim.fn.systemlist("git show " .. sha)

  if vim.v.shell_error ~= 0 or #output == 0 then
    vim.notify("git show failed", vim.log.levels.ERROR, { title = "Git show" })
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)

  -- 4) Activar resaltado de sintaxis para diffs
  -- Si tienes plugin tipo vim-git, puedes probar 'git'
  vim.bo.filetype = "diff"

  -- opcional: nombre virtual del buffer
  vim.api.nvim_buf_set_name(0, "git-show://" .. sha)

  vim.notify("git show " .. sha, vim.log.levels.INFO, { title = "Git show" })
end, { desc = "Show git commit for current line (diff)" })

local zoomed = false

vim.keymap.set("n", "<C-w>z", function()
  if not zoomed then
    vim.cmd("wincmd |")
    vim.cmd("wincmd _")
    zoomed = true
  else
    vim.cmd("wincmd =")
    zoomed = false
  end
end, { desc = "Toggle Zoom" })
