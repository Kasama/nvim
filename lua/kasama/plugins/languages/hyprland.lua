return {
  only_if = function()
    return (vim.fn.executable('hyprctl') == 1 and vim.fn.executable('go') == 1)
  end,
  init = function(use, mason_install)
    mason_install('hyprls')
  end,
  lsp = function(setup_lsp)
    setup_lsp('hyprls')
  end,
}
