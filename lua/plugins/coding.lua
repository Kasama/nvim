return {
  init = function (use)

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
      'windwp/nvim-autopairs', config = function ()
        require('nvim-autopairs').setup {}
      end
    }

    vim.cmd [[let test#strategy = 'neovim']]
    use {
      'janko-m/vim-test',
      config = function()
        local keybind = require('utils').keybind

        keybind({'n', '<leader>tt', '<cmd>TestNearest<CR>'})
        keybind({'n', '<leader>tf', '<cmd>TestFile<CR>'})
        keybind({'n', '<leader>ts', '<cmd>TestSuite<CR>'})
        keybind({'n', '<leader>tl', '<cmd>TestLast<CR>'})
        keybind({'n', '<leader>tv', '<cmd>TestVisit<CR>'})
      end,
    }

    use {
      'mfussenegger/nvim-dap',
      requires = {
        'leoluz/nvim-dap-go',
      },
      config = function()
      end,
    }

    end
  }
