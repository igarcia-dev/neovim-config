return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {},
  },
  {
    { 'mason-org/mason.nvim', version = '1.11.0' },
    { 'mason-org/mason-lspconfig.nvim', version = '1.32.0' },
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        --
      }
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
  },
  {
    'rainbowhxch/accelerated-jk.nvim',
    lazy = false,
    config = function()
      require('accelerated-jk').setup {
        mode = 'time_driven',
        enable_deceleration = false,
        acceleration_motions = { 'j', 'k' },
        acceleration_limit = 150,
        acceleration_table = { 5, 10, 14, 17, 20, 21, 22, 25 },
        deceleration_table = { { 150, 9999 } },
      }
      vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', {})
      vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup {
        override = {},
        default = true,
      }
    end,
  },
  {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
}
  }
}
