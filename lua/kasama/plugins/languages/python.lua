return {
  only_if = function()
    return (vim.fn.executable('python') == 1)
  end,
  init = function(use)
  end,
  lsp = function(setup_lsp)
    if (vim.fn.executable('npm') == 1) then
      setup_lsp("pyright", {})
    end
    -- setup_lsp("pylsp", {})
  end,
}
