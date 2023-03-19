return {
  init = function(use)
    vim.opt.foldmethod = 'expr'
    vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]

    use {
      'rafcamlet/nvim-luapad',
      cmd = { 'Luapad' },
      config = function()
        local luapad = require('luapad')
      end,
    }
  end,
  lsp = function(setup_lsp)
    setup_lsp('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false
          },
          telemetry = {
            enable = false
          },
        }
      },
      single_file_support = true,
      on_attach = function(_, _)
      end,
    })
  end,
  snippets = function()
    local u = require('kasama.snippet-utils')
    local ls = require('luasnip')
    local s, i, t, d, c, f = ls.s, ls.insert_node, ls.text_node, ls.dynamic_node, ls.choice_node, ls.function_node
    local e = require('luasnip.extras')
    local l = e.lambda
    local fmt = require('luasnip.extras.fmt').fmt

    ls.add_snippets('lua', {
      s('lfun', fmt(
        [[local {} = function({}){} end]],
        { i(1), i(2), i(0) }, {})
      ),
      s('lreq', fmt('local {} = require("{}")', {
        l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
        i(1, "module"),
      })
      ),
      s('lang', fmt(
        [[return {{
  init = function(use)
  end,
  lsp = function(setup_lsp)
  end,
  snippets = function()
    local u = require('kasama.snippet-utils')
    local ls = require('luasnip')
    local s, i, t, d, c, f = ls.s, ls.insert_node, ls.text_node, ls.dynamic_node, ls.choice_node, ls.function_node
    local e = require('luasnip.extras')
    local fmt = require('luasnip.extras.fmt')

    ls.add_snippets('{}', {{
    }}, {{ key = '{}' }})

  end,
}}]],
        { c(1, { f(function() return vim.fn.expand('%:t:r') end), i(nil) }), e.rep(1) }, {})
      ),
    }, { key = 'lua' })
  end
}
