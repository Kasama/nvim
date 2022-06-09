package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/lua/lib/?.lua'

vim.g.mapleader = ','
vim.g.localleader =  ';'

require("plugins")

require("options")

require("mappings")

require('augroups')

-- Case insensitive :wq
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
