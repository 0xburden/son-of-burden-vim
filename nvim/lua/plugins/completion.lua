-- ===========================
-- Completion (nvim-cmp)
-- ===========================

return {
  -- Core completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_mapping = require("cmp.config.mapping")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp_mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              vim.api.nvim_feedkeys(vim.keycode("<Plug>(vsnip-expand-or-jump)"), "")
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              vim.api.nvim_feedkeys(vim.keycode("<Plug>(vsnip-jump-prev)"), "")
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Show kind icons
            local kind_icons = {
              Text = "◆",
              Method = "m",
              Function = "f",
              Constructor = "c",
              Field = "field",
              Variable = "v",
              Class = "C",
              Interface = "I",
              Module = "M",
              Property = "p",
              Unit = "U",
              Value = "v",
              Enum = "E",
              Keyword = "k",
              Snippet = "S",
              Color = "c",
              File = "F",
              Reference = "r",
              Folder = "F",
              EnumMember = "e",
              Constant = "c",
              Struct = "s",
              Event = "E",
              Operator = "o",
              TypeParameter = "T",
            }
            vim_item.kind = kind_icons[vim_item.kind] or ""

            -- Show source name
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              vsnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name] or ""

            return vim_item
          end,
        },
        window = {
          documentation = {
            border = "rounded",
          },
        },
        experimental = {
          ghost_text = true,
        },
      })

    end,
  },

  -- LSP source for cmp
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },

  -- Buffer source for cmp
  {
    "hrsh7th/cmp-buffer",
    lazy = true,
  },

  -- Path source for cmp
  {
    "hrsh7th/cmp-path",
    lazy = true,
  },

  -- VSnip source for cmp
  {
    "hrsh7th/cmp-vsnip",
    lazy = true,
  },

  -- Vim VSCode Snippet
  {
    "hrsh7th/vim-vsnip",
    lazy = true,
    config = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
      vim.g.vsnip_enable_autosnippets = true
    end,
  },

}
