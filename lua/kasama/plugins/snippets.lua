return {
  init = function(use)
    use {
      'L3MON4D3/LuaSnip',
      requires = {
        'rafamadriz/friendly-snippets',
      },
      config = function()
        local keybind = require('utils').keybind
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })

        luasnip.config.set_config {
          history = true,

          updateevents = "TextChanged,TextChangedI",

          enable_autosnippets = true
        }

        keybind { { 'i', 's' }, '<c-k>', function()
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          end
        end }
        keybind { { 'i', 's' }, '<c-j>', function()
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          end
        end }
        keybind { { 'i', 's' }, '<c-l>', function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end }

        local load_from = require('utils').load_from_factory('lua/kasama/plugins')
        for _, language_loader in ipairs(load_from('languages')) do
          if type(language_loader.snippets) == "function" then
            language_loader.snippets()
          end
        end
      end,
    }

  end,
}
