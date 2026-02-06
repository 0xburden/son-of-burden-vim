-- ===========================
-- Language Support
-- ===========================

return {
  -- JavaScript/TypeScript syntax
  {
    "yuezk/vim-js",
    ft = { "javascript", "javascriptreact" },
  },
  {
    "HerringtonDarkholme/yats.vim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascriptreact", "typescriptreact" },
  },

  -- Elixir
  {
    "elixir-editors/vim-elixir",
    ft = { "elixir", "eex", "heex", "ex", "exs" },
  },

  -- Solidity
  {
    "tomlion/vim-solidity",
    ft = { "solidity" },
  },

  -- JSON schema validation
  {
    "b0o/SchemaStore.nvim",
    ft = { "json", "jsonc" },
  },
}
