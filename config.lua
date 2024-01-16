-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavor = "macchiato"
    }
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({})
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup({
          suggestion = { enabled = false },
          panel = { enabled = false }
        })
      end
    }

  },
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
}
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black", filetypes = { "python" } },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact" },
  },
}

lvim.format_on_save = true
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8", filetypes = { "python" } },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}
lvim.colorscheme = "catppuccin-macchiato"

lvim.keys.normal_mode["<F2>"] = { vim.lsp.buf.rename }
lvim.lsp.buffer_mappings.normal_mode['gh'] = { vim.lsp.buf.hover, "Show documentation" }



lvim.builtin.which_key.mappings = {
  ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  ["f"] = { '<cmd>Telescope find_files<CR>', "Find Files" },
  ["g"] = { '<cmd>Telescope live_grep<CR>', "Live Grep" },
  ["t"] = { '<cmd>Telescope buffers<CR>', "Switch Buffers" },
  ["lf"] = {
    '<cmd>lua vim.lsp.buf.format()<CR>',
    "Format File",
  },



  p = {
    name = "Plugins",
    i = { "<cmd>Lazy install<cr>", "Install" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    S = { "<cmd>Lazy clear<cr>", "Status" },
    u = { "<cmd>Lazy update<cr>", "Update" },
  },
}

lvim.builtin.treesitter.ensure_installed = {
  "python",
}
vim.opt.relativenumber = true

-- Below config is required to prevent copilot overriding Tab with a suggestion
-- when you're just trying to indent!
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
local on_tab = vim.schedule_wrap(function(fallback)
  local cmp = require("cmp")
  if cmp.visible() and has_words_before() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  else
    fallback()
  end
end)
lvim.builtin.cmp.mapping["<Tab>"] = on_tab
