-- ===========================
-- Formatting (conform.nvim)
-- ===========================

return {
  -- Formatter plugin
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "Format" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- JavaScript/TypeScript
          javascript = { "prettierd", "prettier", "eslint_d" },
          javascriptreact = { "prettierd", "prettier", "eslint_d" },
          typescript = { "prettierd", "prettier", "eslint_d" },
          typescriptreact = { "prettierd", "prettier", "eslint_d" },
          -- Web formats
          json = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          less = { "prettierd", "prettier" },
          -- Lua
          lua = { "stylua" },
          -- Markdown
          markdown = { "prettierd", "prettier" },
          -- Python
          python = { "black", "ruff" },
          -- Shell
          sh = { "shfmt" },
          bash = { "shfmt" },
          -- Go
          go = { "gofmt" },
          -- Rust
          rust = { "rustfmt" },
          -- SQL
          sql = { "sqlfmt" },
          -- Vim
          vim = { "vim_lsp" },
        },
        formatters = {
          -- Custom formatter configurations
          prettier = {
            args = {
              "--tab-width",
              "2",
              "--use-tabs",
              "false",
              "--single-quote",
              "true",
              "--print-width",
              "100",
            },
          },
        },
        format_on_save = function(bufnr)
          -- Disable format on save for some files
          if vim.g.disable_format_on_save then
            return
          end
          local filename = vim.api.nvim_buf_get_name(bufnr)
          -- Ignore certain files
          if filename:match("%.min%.%w+$") then
            return
          end
          return {
            lsp_fallback = true,
            async = false,
          }
        end,
        format_after_save = function(bufnr)
          if vim.g.format_after_save_enabled then
            return { lsp_fallback = true }
          end
        end,
      })

      -- Create Format command
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({
          async = true,
          lsp_fallback = true,
          range = range,
        })
      end, { range = true })

      -- Toggle format on save
      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.disable_format_on_save = not vim.g.disable_format_on_save
        print(
          "Format on save: "
            .. (vim.g.disable_format_on_save and "disabled" or "enabled")
        )
      end, {})
    end,
  },
}
