local fn = vim.fn
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_bootstrap
if fn.empty(fn.glob(packer_install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_path})
end

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
local utils = require('utils')

local packer_group = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { group = packer_group, pattern = {
    fn.stdpath('config') .. "/lua/plugins.lua",
    fn.stdpath('config') .. "/lua/plugins/*.lua"
  }, command = "source " .. fn.stdpath('config') .. "/lua/plugins.lua | PackerCompile profile=true" }
)

LOADED_PLUGINS = {}
function TableConcat(t1, t2)
  for i=1,#t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end

return packer.startup(function()

  --- General packages not related to plugins ---
  -- packer will manage itself
  packer.use 'wbthomason/packer.nvim'
  -- basically a lua stdlib for neovim. Used by many plugins
  packer.use 'nvim-lua/plenary.nvim'
  -- fix for https://github.com/neovim/neovim/issues/12587. Can be removed if that gets fixed
  packer.use 'antoinemadec/FixCursorHold.nvim'

  -- load plugins
  local load_from = utils.load_from_factory('lua')

  local loaded = load_from('plugins')

  for _, plugin_loader in pairs(loaded) do
    plugin_loader.init(packer.use)
  end
  TableConcat(LOADED_PLUGINS, loaded)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    vim.notify("Installing plugins...")
    packer.sync()
  end

  if utils.file_modified(fn.stdpath('config') .. '/lua') > utils.file_modified(packer.config.compile_path) then
    vim.notify("Recompiling configs...", vim.log.levels.INFO, {title = "Packer"})
    packer.compile()
  end
end)
