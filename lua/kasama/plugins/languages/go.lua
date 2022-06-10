return {
  lsp = function(setup_lsp)
    setup_lsp('gopls', {
      staticcheck = true,
      codelenses = {
        generate = true
      }
    })
  end,
  snippets = function()
    local ls = require('luasnip')
    local s, i, t, c, f = ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node
    local fmt = require('luasnip.extras.fmt').fmt

    ls.add_snippets('go', {
      s('test', fmt([[This is a test snippet huchssuihcauishcsdu {}]], { c(1, { t "hay", t "hey" }) }, {})),
      -- s('ife', fmt([[]], {}, {})),
    }, { key = 'go' })
  end,
}
