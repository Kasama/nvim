local gitCommitSpelling = vim.api.nvim_create_augroup("GitCommitSpell", { clear = true })
vim.api.nvim_create_autocmd(
  "FileType",
  { group = gitCommitSpelling, pattern = 'gitcommit', command = "setlocal spell" }
)

-- Force preview window splits to open on the bottom instead of to the side
local previewOnBottom = vim.api.nvim_create_augroup("PreviewOnBottom", { clear = true })
vim.api.nvim_create_autocmd(
  "InsertEnter",
  { group = previewOnBottom, pattern = '*', command = "setlocal splitbelow" }
)
vim.api.nvim_create_autocmd(
  "InsertLeave",
  { group = previewOnBottom, pattern = '*', command = "setlocal splitbelow!" }
)
