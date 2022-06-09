return {
  init = function(use)
    use {
      'L3MON4D3/LuaSnip',
      requires = {
        'rafamadriz/friendly-snippets',
      },
      config = function()
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })

        luasnip.config.set_config {
          history = true,

          updateevents = "TextChanged,TextChangedI",

          enable_autosnippets = true
        }
      end,
    }
  end,
}
