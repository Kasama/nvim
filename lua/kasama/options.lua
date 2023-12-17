local opt = vim.opt

opt.syntax = 'on'
opt.laststatus = 2
opt.showmode = false
opt.whichwrap = "b,s,<,>,[,]"
opt.hlsearch = true
opt.foldmarker = "{,}"
opt.foldmethod = 'marker'
opt.foldlevelstart = 99
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.tabstop = 2
opt.shiftwidth = opt.tabstop:get()
opt.softtabstop = opt.tabstop:get()
opt.expandtab = true
opt.exrc = true
opt.secure = true
opt.hidden = true
opt.number = true
opt.relativenumber = false
-- opt.completeopt = 'longest,menu,preview'
opt.completeopt = 'menu,menuone,noselect'
opt.lazyredraw = true
opt.title = true
opt.inccommand = 'split'
opt.mouse = 'a'
opt.mousemodel = 'extend'
opt.signcolumn = 'yes'
opt.listchars = {
  tab = '» ',
  trail = '¶',
  space = '·',
  eol = '↵',
}
opt.diffopt = "linematch:50"

-- notify override
local ok, notify = pcall(require, "notify")
if ok then
  vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
      return
    end
    if msg:match("LanguageTree:for_each_child() is deprecated, use LanguageTree:children() instead.") then
      return
    end
    if msg:match("share/nvim/runtime/lua/vim/treesitter/languagetree.lua:466: in function 'for_each_child'") then
      return
    end

    notify(msg, ...)
  end
end
