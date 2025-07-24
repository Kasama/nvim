return {
  only_if = function()
    return (vim.fn.executable('nix') == 1 and vim.fn.executable('cargo') == 1)
  end,
  init = function(use, mason_install)
    mason_install('nixfmt')
  end,
  lsp = function(setup_lsp)
    setup_lsp("nil_ls", {})
  end,
  snippets = function()
    local ls = require('luasnip')
    local s, i, t, d, f, sn = ls.s, ls.insert_node, ls.text_node, ls.dynamic_node, ls.function_node, ls.sn

    ls.add_snippets('nix', {
      s('mod', {
        t({ '{ config, lib, pkgs, ... }:', '{', '  options = {', '    ' }),
        i(1, 'mod'), t('.enable = lib.mkEnableOption "enable '), f(function(args) return args[1] end, {1}),
        t({ '";', '  };', '', '  config = lib.mkIf config.'}),
        f(function(args) return args[1] end, {1}),
        t({'.enable {', '    ' }),
        i(0),
        t({';', '  };', '}'})
      })
    })
  end,
}
