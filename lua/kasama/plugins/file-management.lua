return {
  init = function(use)
    use { -- nvim tree
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      config = function()
        require('nvim-tree').setup {
          git = {
            enable = false,
          },
          renderer = {
            indent_markers = {
              enable = true,
            },
          },
          view = {
            mappings = {
              list = {
                { key = 'A', action = 'create' }
              }
            }
          }
        }

        local keybind = require('utils').keybind
        keybind({ 'n', [[\]], '<cmd>NvimTreeFindFileToggle<CR>' })
      end
    }
  end,
}
