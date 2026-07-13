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
  },
  defaults = {
    lazy = false,
    version = false,
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
