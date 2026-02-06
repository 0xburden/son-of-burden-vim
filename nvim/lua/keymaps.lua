-- ===========================
-- General Remaps
-- ===========================

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- File explorer
keymap.set("n", "<leader>n", ":Lexplore<CR>", opts)

-- Format code
keymap.set("n", "<leader>p", ":Format<CR>", opts)

-- Terminal splits
keymap.set("n", "<leader>t", ":split | terminal<CR>", opts)
keymap.set("n", "<leader>T", ":vsplit | terminal<CR>", opts)

-- Buffer splits
keymap.set("n", "<leader>h", ":split | enew<CR>", opts)
keymap.set("n", "<leader>v", ":vsplit | enew<CR>", opts)

-- ===========================
-- LSP Keymaps (when attached)
-- ===========================

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf, noremap = true, silent = true }

    -- Go to definition
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    -- Hover
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Rename
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- References
    keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Diagnostics
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    -- Code actions
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
