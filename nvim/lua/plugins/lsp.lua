-- ===========================
-- LSP & Language Servers
-- ===========================

return {
  -- Mason (package manager for LSP, DAP, linters, formatters)
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          height = 0.85,
          width = 0.9,
        },
      })
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configurations
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- TypeScript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- JSON
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
      })

      -- HTML/CSS
      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("cssls", { capabilities = capabilities })

      -- Enable language servers
      vim.lsp.enable({ "ts_ls", "lua_ls", "jsonls", "html", "cssls" })

      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })
    end,
  },
}
