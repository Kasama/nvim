return {
  init = function(use)
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { -- Telescope
      'nvim-telescope/telescope.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
          module_pattern = "telescope._extensions.fzf"
        },
      },
      init = function()
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>a', '<cmd>Telescope live_grep<CR>' })
        keybind({ 'n', '<leader>f', '<cmd>Telescope find_files prompt_prefix=<CR>' })
        keybind({ 'n', '<leader>b', '<cmd>Telescope buffers<CR>' })
        keybind({ 'n', '<leader>n', '<cmd>Telescope notify<CR>' })
        keybind({ 'n', '<leader>p', require('telescope.builtin').commands })
      end,
      cmd = 'Telescope',
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

        -- extensions
        telescope.load_extension('notify')
        telescope.load_extension('ui-select')
        if not (vim.fn.executable('fzf') == 0) then
          telescope.load_extension('fzf')
        end
      end,
    }
  end,
}
