-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core settings
require("options")
require("keymaps")

-- Plugin specs
require("lazy").setup({
  { import = "plugins" },
}, {
  ui = {
    size = { width = 0.85, height = 0.85 },
    border = "rounded",
    backdrop = 60,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- keep netrw enabled (you use :Lexplore)
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})

-- Execute file-type detection and syntax
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
