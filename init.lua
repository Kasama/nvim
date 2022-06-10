package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/kasama/lib/?.lua'

LOADED_MODULES = {}
local normal_require = _G.require
_G.require = function(module)
  LOADED_MODULES[module] = (LOADED_MODULES[module] or 0) + 1
  return normal_require(module)
end

vim.g.mapleader = ','
vim.g.localleader = ';'

require('kasama.plugins')

require('kasama.options')

require('kasama.mappings')

require('kasama.augroups')

-- Case insensitive :wq
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})

-- print(vim.inspect(LOADED_MODULES))

-- Reload everything
require('utils').keybind({ 'n', '<leader>rc', function()
  require('plenary.reload').reload_module('kasama')
  require('plenary.reload').reload_module('utils')
  require('plenary.reload').reload_module('plugins')
  require('plenary.reload').reload_module('languages')
  vim.cmd [[source $MYVIMRC]]
end })
