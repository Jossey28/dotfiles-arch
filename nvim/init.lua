-- ==========================================
-- Basic Editor Settings (Options)
-- ==========================================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"

-- ==========================================
-- Keymaps
-- ==========================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Delete without changing internal registers or clipboard
vim.keymap.set({'n', 'v'}, 'd', '"_d', { desc = "Delete without yanking" })
vim.keymap.set({'n', 'v'}, 'D', '"_D', { desc = "Delete line without yanking" })
vim.keymap.set({'n', 'v'}, 'c', '"_c', { desc = "Change without yanking" })
vim.keymap.set({'n', 'v'}, 'C', '"_C', { desc = "Change line without yanking" })


-- ==========================================
-- Plugin Manager (lazy.nvim Bootstrap)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugins
require("lazy").setup({
  defaults = {
    lazy = false,
    version = false,
  },

  spec = {
    -- 1. Load the core LazyVim framework settings & UI
    { "LazyVim/LazyVim" },

    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "bash", "c", "lua", "python", "vim", "vimdoc", "javascript", "typescript" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      },
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls" }
        })
      end
    },

    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = 'default' },
        appearance = {
          nerd_font_variant = 'mono'
        },

        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        completion = { documentation = { auto_show = false } },
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
        opts_extend = { "sources.default" }

    }
  },
})

vim.cmd.colorscheme "catppuccin-macchiato"
-- ==========================================
-- LSP Stuff (https://www.reddit.com/r/neovim/comments/1jw0zav/psa_heres_a_quick_guide_to_using_the_new_built_in)
-- ==========================================

vim.lsp.enable({
  -- lua
  "luals",
})
