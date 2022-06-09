return {
  init = function(use)
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { -- Telescope
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
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

        keybind({ 'n', '<leader>a', '<cmd>Telescope live_grep<CR>' })
        keybind({ 'n', '<leader>f', '<cmd>Telescope find_files prompt_prefix=<CR>' })
        keybind({ 'n', '<leader>b', '<cmd>Telescope buffers<CR>' })
        keybind({ 'n', '<leader>n', '<cmd>Telescope notify<CR>' })

        -- extensions
        telescope.load_extension('notify')
        telescope.load_extension('ui-select')
        telescope.load_extension('fzf')
      end,
    }

    use {
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
          }
        }

        local keybind = require('utils').keybind
        keybind({ 'n', [[\]], '<cmd>NvimTreeToggle<CR>' })
      end
    }
  end,
}
