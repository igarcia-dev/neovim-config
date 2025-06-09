return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
{
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
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
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
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
        -- cuando presionas 'j' 7 veces rápidamente, te moverá 30 líneas
        deceleration_table = { { 150, 9999 } },
      }

      vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', {})
      vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end,
  },
{
  "sphamba/smear-cursor.nvim",
  lazy = false,
  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
  },
{
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = true,
},
  -- En tu plugins.lua o como lo tengas configurado
}
}
