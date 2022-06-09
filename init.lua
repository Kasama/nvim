package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/lib/?.lua'

LOADED_MODULES = {}
local normal_require = _G.require
_G.require = function(module)
  LOADED_MODULES[module] = (LOADED_MODULES[module] or 0) + 1
  return normal_require(module)
end

vim.g.mapleader = ','
vim.g.localleader = ';'

require("plugins")

require("options")

require("mappings")

require('augroups')

-- Case insensitive :wq
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})

-- print(vim.inspect(LOADED_MODULES))

-- Reload everything
require('utils').keybind({ 'n', '<leader>rc', function()
  for mod, _ in pairs(LOADED_MODULES) do
    if not string.find(mod, "^vim.") then
      LOADED_MODULES[mod] = nil
      package.loaded[mod] = nil
    end
  end
  vim.cmd [[source $MYVIMRC]]
  vim.cmd [[PackerCompile]]
end })
