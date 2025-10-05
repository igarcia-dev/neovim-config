require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.css", "*.scss", "*.html", "*.md" },
  callback = function()
    vim.cmd("silent !prettier --write %")
    vim.cmd("edit")
  end,
})
