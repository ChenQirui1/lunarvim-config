-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
  opts = {
      flavor = "frappe"
    }},

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
  ft = {"fugitive"}
},
}

lvim.colorscheme = "catppuccin-frappe"

lvim.keys.normal_mode["<leader>e"] = "<cmd>:NvimTreeToggle<CR>"
lvim.lsp.buffer_mappings.normal_mode['H'] = { vim.lsp.buf.hover, "Show documentation" }



lvim.builtin.which_key.mappings = {
  ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  ["<F4>"] = {'<cmd>Telescope find_files<CR>', "Find Files"},

  p = {
    name = "Plugins",
    i = { "<cmd>Lazy install<cr>", "Install" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    S = { "<cmd>Lazy clear<cr>", "Status" },
    u = { "<cmd>Lazy update<cr>", "Update" },
  },
}

