return {
  init = function(use)
    use { 'ziglang/zig.vim', ft = 'zig' }
  end,
  lsp = function(setup_lsp)
    setup_lsp("zls")
  end,
}
