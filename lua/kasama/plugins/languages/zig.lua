return {
  only_if = function()
    return (vim.fn.executable('zip') == 1)
  end,
  init = function(use)
    use { 'ziglang/zig.vim', ft = 'zig' }
  end,
  lsp = function(setup_lsp)
    setup_lsp("zls")
  end,
}
