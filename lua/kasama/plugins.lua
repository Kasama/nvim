local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: add hot-reload on plugins change

local plugins = {
  {}
}

local use = function(tbl)
  if type(tbl) == "string" then
    tbl = { tbl }
  end
  vim.list_extend(plugins, { tbl })
end

ENSURE_INSTALLED_MASON = {}

--- General packages not related to plugins ---
-- package manager for external things (lsp, dap, etc)
use {
  'williamboman/mason.nvim',
  event = 'VeryLazy',
  dependencies = { 'mason-tool-installer.nvim' },
  config = function()
    require('mason').setup()
  end
}
local mason_install = function(value)
  -- use as a set to remove duplicates
  ENSURE_INSTALLED_MASON[value] = true
end
-- basically a lua stdlib for neovim. Used by many plugins
use 'nvim-lua/plenary.nvim'

-- load plugins
local utils = require('utils')
local load_from = utils.load_from_factory('lua/kasama')

local loaded = load_from('plugins')

for _, plugin_loader in pairs(loaded) do
  if type(plugin_loader.init) == 'function' then
    plugin_loader.init(use, mason_install)
  end
end

-- load mason packages
use {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  config = function()
    local ensure_installed = {}
    for k, _ in pairs(ENSURE_INSTALLED_MASON) do
      table.insert(ensure_installed, k)
    end
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
    }
  end
}

require('lazy').setup(plugins, {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "onedark" }
  }
})
