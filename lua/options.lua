require "nvchad.options"

vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.cursorline = true

-- o.cursorlineopt ='both' -- to enable cursorline!

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200
    })
  end,
})
