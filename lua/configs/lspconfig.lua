-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local util = require("lspconfig/util")
local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "typscript-language-server", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

require("lspconfig").tsserver.setup({})

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
lspconfig.pyright.setup {
  capabilities = capabilities;
  on_attach = on_attach;
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  before_init = function (_, config)
    local venv_path = util.path.join(vim.fn.getcwd(), "venv")
    local python_path = util.path.join(venv_path, "bin", "python")
    config.settings.python.venvPath = venv_path
    config.settings.python.pythonPath = python_path
  end,
}
lspconfig.svelte.setup {
  filetypes = { "svelte" },
  on_attach = function(client, bufnr)
    if client.name == 'svelte' then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
    if vim.bo[bufnr].filetype == "svelte" then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
  end
}
lspconfig.astro.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "astro" }
})


