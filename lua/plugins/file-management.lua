return {
  init = function(use)
    use {'nvim-telescope/telescope-ui-select.nvim' }

    use { -- Telescope
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function()
        local actions = require('telescope.actions')

        local telescope = require('telescope')
        telescope.setup {
          defaults = {
            mappings = {
              i = {
                ['<esc>'] = actions.close,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
              }
            }
          },
          extensions = {
            ["ui-select"] = {
              require('telescope.themes').get_dropdown {}
            },
          },
        }

        local keybind = require('utils').keybind

        keybind({'n', '<leader>a', '<cmd>Telescope live_grep<CR>'})
        keybind({'n', '<leader>f', '<cmd>Telescope find_files prompt_prefix=<CR>'})
        keybind({'n', '<leader>b', '<cmd>Telescope buffers<CR>'})
        keybind({'n', '<leader>n', '<cmd>Telescope notify<CR>'})

        -- extensions
        telescope.load_extension('notify')
        telescope.load_extension('ui-select')
      end,
    }

    use { -- CHAD tree
      'ms-jpq/chadtree',
      run = 'CHADdeps',
      config = function()
        local keybind = require('utils').keybind
        keybind({'n', [[\]], '<cmd>CHADopen<CR>'})
      end,
    }
  end,
}
