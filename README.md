# son-of-burden-vim

My personal, **reproducible Neovim configuration**.

- Plugin manager: **[lazy.nvim](https://github.com/folke/lazy.nvim)**
- LSP: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`
- Completion: `nvim-cmp` (+ `vim-vsnip`)
- Formatting: `conform.nvim`
- Theme: **Ayu (dark)**

This repo is structured so that `nvim/` can be symlinked directly to `~/.config/nvim`.

## Repository layout

```
.
├── nvim/              # the Neovim config directory (what normally lives at ~/.config/nvim)
└── scripts/
    ├── install.sh     # symlink install into ~/.config/nvim + optional Lazy sync
    ├── bootstrap.sh   # clone + install helper (for new machines)
    └── sync-from-local.sh  # import ~/.config/nvim back into this repo
```

## Requirements

- Neovim **0.11+**
- `git`
- Optional (recommended): `ripgrep` (`rg`) and `fd`

## Install

```bash
git clone <YOUR_REPO_URL> ~/code/son-of-burden-vim
~/code/son-of-burden-vim/scripts/install.sh
```

`install.sh` will:
- back up an existing `~/.config/nvim` to `~/.config/nvim.bak.<timestamp>`
- symlink `~/code/son-of-burden-vim/nvim` → `~/.config/nvim`
- run `nvim --headless "+Lazy! sync" +qa` when available

## Updating / publishing changes

Recommended workflow (because install uses a symlink):

1. Edit config inside the repo: `~/code/son-of-burden-vim/nvim/...`
2. In Neovim: `:Lazy sync`
3. Commit + push

If you edited `~/.config/nvim` directly (not the repo):

```bash
~/code/son-of-burden-vim/scripts/sync-from-local.sh
```

## Included plugins (high level)

### Core / UX
- `ayu-theme/ayu-vim` — colorscheme (dark)
- `itchyny/lightline.vim` — statusline
- `stevearc/dressing.nvim` — nicer `vim.ui.input()` / `vim.ui.select()`
- `folke/snacks.nvim` — assorted modern utilities (lightly enabled)
- `nvim-tree/nvim-web-devicons` — filetype icons

### Fuzzy finding
- `ibhagwan/fzf-lua` — file/buffer/grep picker

### LSP
- `williamboman/mason.nvim` — installs language servers / tools
- `williamboman/mason-lspconfig.nvim` — mason ↔ lspconfig glue
- `neovim/nvim-lspconfig` — LSP client configs

### Completion
- `hrsh7th/nvim-cmp` — completion UI
- `hrsh7th/cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-vsnip`
- `hrsh7th/vim-vsnip` — snippet engine

### Formatting
- `stevearc/conform.nvim` — formatting + `:Format` / format-on-save

### Treesitter
- `nvim-treesitter/nvim-treesitter`
- `nvim-treesitter/nvim-treesitter-textobjects`
- `nvim-treesitter/nvim-treesitter-context`

> Treesitter parsers are installed manually via `:TSInstall ...` (no auto-install loop on startup).

### Language extras
- JS/TS syntax: `yuezk/vim-js`, `HerringtonDarkholme/yats.vim`, `maxmellon/vim-jsx-pretty`
- Elixir: `elixir-editors/vim-elixir`
- Solidity: `tomlion/vim-solidity`
- JSON schemas: `b0o/SchemaStore.nvim`

### Misc
- `windwp/nvim-autopairs` — auto-pairs
- `HakonHarnes/img-clip.nvim` — paste images from clipboard into markdown/html
- `MeanderingProgrammer/render-markdown.nvim` — improved markdown rendering

## Custom keybindings

Leader is:
- `<leader>` = `;`

### Files / navigation
- `<C-p>` — fzf-lua files
- `<leader><C-p>` — fzf-lua live grep
- `<leader>fb` — fzf-lua buffers
- `<leader>n` — netrw file explorer (`:Lexplore`)

### Formatting
- `<leader>p` — `:Format`
- `:FormatToggle` — toggle format-on-save

### Splits / terminal
- `<leader>t` — horizontal terminal split
- `<leader>T` — vertical terminal split
- `<leader>h` — horizontal split + new empty buffer
- `<leader>v` — vertical split + new empty buffer

### LSP (buffer-local; active after server attaches)
- `gd` — go to definition
- `K` — hover docs
- `gr` — references
- `<leader>rn` — rename symbol
- `<leader>ca` — code action
- `]d` / `[d` — next/prev diagnostic
- `<leader>d` — diagnostic float

## First-time setup notes

After install, these are the usual next steps:

- Plugins:
  - `:Lazy sync`
- LSP servers / tools:
  - `:Mason` (then install what you want)
- Treesitter parsers:
  - `:TSInstall lua javascript typescript tsx json html css scss markdown bash`

## Where to change things

- Options: `nvim/lua/options.lua`
- Keymaps: `nvim/lua/keymaps.lua`
- Plugins:
  - `nvim/lua/plugins/theme.lua`
  - `nvim/lua/plugins/lsp.lua`
  - `nvim/lua/plugins/completion.lua`
  - `nvim/lua/plugins/formatting.lua`
  - `nvim/lua/plugins/treesitter.lua`
  - `nvim/lua/plugins/utils.lua`
  - `nvim/lua/plugins/lang.lua`

## Troubleshooting

### "Cannot find color scheme 'ayu'"

Run:

- `:Lazy sync`

The theme plugin (`ayu-theme/ayu-vim`) needs to be installed before `colorscheme ayu` can load.

### Fuzzy finder (`<C-p>`) not working

- Check `:messages` for fzf-lua errors
- Make sure you have the `fzf` binary installed (recommended):
  - macOS: `brew install fzf`
  - Arch: `pacman -S fzf`
  - Ubuntu/Debian: `apt install fzf`

### Treesitter errors / parsers won’t install

This config **does not auto-install parsers** on startup.

1. Install parsers manually:
   - `:TSInstall lua javascript typescript tsx`
2. If it still fails, check logs:
   - `:TSLog`
3. Ensure you have a compiler toolchain (typically required):
   - `gcc`/`clang` and `make`

You can also check whether parsers exist on disk:

- `~/.local/share/nvim/site/parser/` (should contain `*.so` files)

### LSP not attaching / no diagnostics

- `:LspInfo` to see what’s attached
- `:Mason` to install language servers
- Restart Neovim after installing servers

### Formatting not working

- `:ConformInfo`
- Install formatters (either via Mason or your system): `prettierd`, `eslint_d`, `stylua`, etc.

### Hard reset plugin state

If things get weird after big changes:

- `rm -rf ~/.local/share/nvim/lazy`
- then start Neovim and run `:Lazy sync`

## Sensitive information / secrets

This repository is intended to be **safe to publish**:

- No API keys, tokens, passwords, or machine-specific secrets are stored in the tracked config.
- `lazy-lock.json` contains plugin commit hashes and is safe to commit.
- Runtime/plugin state (logins, caches, etc.) is stored outside the repo (in your local Neovim data/cache dirs), not in `nvim/`.

If you add plugins that require secrets in the future, prefer one of:

- environment variables
- local untracked files (and add them to `.gitignore`)

