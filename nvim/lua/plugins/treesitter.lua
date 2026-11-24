-- ===========================
-- Treesitter
--
-- NOTE: nvim-treesitter recently changed its public API.
-- There is no `require('nvim-treesitter.configs')` anymore.
-- Tree-sitter highlighting is provided by Neovim itself and must be
-- enabled (e.g. via a FileType autocmd).
-- ===========================

local filetypes = {
  "lua",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "html",
  "css",
  "scss",
  "markdown",
  "sh",
  "bash",
  "python",
  "go",
  "rust",
  "sql",
  "vim",
  "vimdoc",
  "elixir",
  "eelixir",
  "heex",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterEnable", { clear = true }),
        pattern = filetypes,
        callback = function(ev)
          -- Highlighting (provided by Neovim)
          pcall(vim.treesitter.start, ev.buf)

          -- Indentation (provided by nvim-treesitter)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 5,
      trim_scope = "inner",
    },
  },
}
