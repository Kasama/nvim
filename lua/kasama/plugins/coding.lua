return {
  init = function(use)

    -- must have surround
    use { 'tpope/vim-surround' }

    -- automatically load editorconfig
    use { 'editorconfig/editorconfig-vim' }

    -- live scratchpad
    use { 'metakirby5/codi.vim' }

    use { -- Treesitter
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      {
        'nvim-treesitter/playground',
        config = function()
          require('nvim-treesitter.configs').setup {
            ensure_installed = {
              'c',
              'cpp',
              'css',
              'dockerfile',
              'elm',
              'go',
              'haskell',
              'html',
              'java',
              'javascript',
              'json',
              'json5',
              'lua',
              'python',
              'query',
              'rust',
              'scss',
              'toml',
              'typescript',
              'yaml',
            },

            highlight = { enable = true },
            indent = { enable = true },

            playground = {
              enable = true,
              disable = {},
              updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
              persist_queries = false, -- Whether the query persists across vim sessions
              keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
              },
            }
          }
        end
      }
    }

    use { -- auto pairs
      'windwp/nvim-autopairs', config = function()
        require('nvim-autopairs').setup {}
      end
    }

    vim.cmd [[let test#strategy = 'neovim']]
    use { -- Tests
      'janko-m/vim-test',
      config = function()
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>tt', '<cmd>TestNearest<CR>' })
        keybind({ 'n', '<leader>tf', '<cmd>TestFile<CR>' })
        keybind({ 'n', '<leader>ts', '<cmd>TestSuite<CR>' })
        keybind({ 'n', '<leader>tl', '<cmd>TestLast<CR>' })
        keybind({ 'n', '<leader>tv', '<cmd>TestVisit<CR>' })
      end,
    }

    use { -- nvim-dap (debugger)
      'mfussenegger/nvim-dap',
      requires = {
        'leoluz/nvim-dap-go',
      },
      config = function()
      end,
    }

    use { -- refactoring
      'ThePrimeagen/refactoring.nvim',
      requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
      },
      config = function()
        local refactoring = require('refactoring')
        refactoring.setup {
          prompt_func_return_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
          },
          prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
          }
        }

        local telescope = require("telescope")
        local keybind = require("utils").keybind
        if telescope then
          telescope.load_extension('refactoring')
          keybind({ { 'v' }, '<leader>rf', '<esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>' })
        end
      end
    }

  end
}
