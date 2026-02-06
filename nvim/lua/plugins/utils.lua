-- ===========================
-- Utilities & File Tools
-- ===========================

return {
  -- Auto pairs (pear-tree replacement)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]",
      enable_moveright = true,
      enable_afterquote = true,
      enable_braceless = true,
      check_ts = true,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    },
  },

  -- Image clipboard support
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufReadPre",
    cmd = { "ImgClipPaste", "ImgClipPasteInto", "ImgClipCopyFrom" },
    config = function()
      require("img-clip").setup({
        default = {
          anchor = "center",
          expand = "no",
          image_width = nil,
          image_height = nil,
          relative = "cursor",
          placement = "after_cursor",
        },
        filetypes = {
          markdown = {
            img_dir = "assets/images",
            img_name = "image",
            extension = "png",
            relative = true,
          },
          html = {
            img_dir = "images",
            img_name = "img",
            extension = "png",
            relative = true,
          },
        },
        prompt_for_file_name = true,
      })
    end,
  },

  -- Fuzzy finder (replaces neovim-fuzzy)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
      {
        "<C-p>",
        function()
          require("fzf-lua").files()
        end,
        mode = "n",
        desc = "Fuzzy find files",
      },
      {
        "<leader><C-p>",
        function()
          require("fzf-lua").live_grep()
        end,
        mode = "n",
        desc = "Fuzzy live grep",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        mode = "n",
        desc = "Fuzzy buffers",
      },
    },
    config = function()
      local fzf = require("fzf-lua")

      fzf.setup({
        winopts = {
          height = 0.9,
          width = 0.9,
          border = "rounded",
          preview = {
            border = "rounded",
            wrap = "word",
          },
        },
        files = {
          -- fzf-lua expects cwd to be a string path if provided
          fd_opts = "--hidden --exclude=.git --exclude=node_modules",
        },
        grep = {
          rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
          fd_opts = "--hidden --exclude=.git --exclude=node_modules",
        },
      })

      -- Compatibility commands (in case muscle memory expects them)
      vim.api.nvim_create_user_command("FuzzyOpen", function()
        fzf.files()
      end, {})
      vim.api.nvim_create_user_command("FuzzyFiles", function()
        fzf.files()
      end, {})
      vim.api.nvim_create_user_command("FuzzyBuffers", function()
        fzf.buffers()
      end, {})
      vim.api.nvim_create_user_command("FuzzyLiveGrep", function()
        fzf.live_grep()
      end, {})
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
    ft = { "markdown", "quarto", "rmd" },
    config = function()
      require("render-markdown").setup({
        headings = {
          icons = { "◉", "○", "●", "◎", "◆" },
          width = "block",
          left_margin = 0,
          align = "left",
        },
        dash = { language = "yaml" },
      })
    end,
  },

  -- Plenary (required by many plugins)
  { "nvim-lua/plenary.nvim", lazy = true },

  -- NUI components (required by many plugins)
  { "MunifTanjim/nui.nvim", lazy = true },
}
