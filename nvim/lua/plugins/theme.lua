-- ===========================
-- Theme & UI
-- ===========================

return {
  -- Ayu theme
  {
    "ayu-theme/ayu-vim",
    priority = 1000,
    config = function()
      vim.g.ayu_style = "dark"
      vim.cmd("colorscheme ayu")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "itchyny/lightline.vim",
    lazy = false,
    config = function()
      -- Keep lightline minimal (no extra dependencies)
      vim.g.lightline = {
        colorscheme = "ayu",
      }
    end,
  },

  -- Enhanced UI inputs
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = {
        border = "rounded",
        title_pos = "center",
      },
      select = {
        border = "rounded",
        backend = { "telescope", "fzf_lua", "fzf", "builtin" },
      },
    },
  },

  -- Modern utilities
  {
    "folke/snacks.nvim",
    lazy = true,
    opts = {
      picker = {
        enabled = true,
      },
      terminal = {
        winbar = false,
      },
    },
  },
}
