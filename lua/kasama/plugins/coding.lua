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
      requires = { -- plugins
        'nvim-treesitter/playground',
        'p00f/nvim-ts-rainbow', -- rainbow parens
        'nvim-treesitter/nvim-treesitter-context',
        -- 'haringsrob/nvim_context_vt', -- Show virtual text with current context
      },
      config = function()

        -- Treesitter Config
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'c', 'cpp', 'css', 'dockerfile', 'elm', 'go', 'haskell', 'hcl', 'html',
            'java', 'java', 'javascript', 'json', 'json5', 'lua', 'python',
            'query', 'regex', 'ruby', 'rust', 'scss', 'toml', 'tsx', 'typescript', 'yaml',
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
          },

          rainbow = { -- rainbow parens
            enable = true,
            colors = { '#b452cd', '#cd8162', '#eeaeee', '#ff69b4' }
          }
        }

        require('treesitter-context').setup({
          max_lines = 3,
        })

        -- FIX for rust SQL highlight injection
        require('vim.treesitter.query').set_query('rust', 'injections', [[
        (macro_definition
          (macro_rule
            left: (token_tree_pattern) @rust
            right: (token_tree) @rust))

        [
          (line_comment)
          (block_comment)
        ] @comment

        (
          (macro_invocation
            macro: ((identifier) @_html_def)
            (token_tree) @html)

            (#eq? @_html_def "html")
        )

        (call_expression
          function: (scoped_identifier
            path: (identifier) @_regex (#eq? @_regex "Regex")
            name: (identifier) @_new (#eq? @_new "new"))
          arguments: (arguments
            (raw_string_literal) @regex))

        (call_expression
          function: (scoped_identifier
            path: (scoped_identifier (identifier) @_regex (#eq? @_regex "Regex").)
            name: (identifier) @_new (#eq? @_new "new"))
          arguments: (arguments
            (raw_string_literal) @regex))
                ]])
      end
    }

    use { -- tree climber
      'drybalka/tree-climber.nvim',
      requires = {
        { "nvim-treesitter/nvim-treesitter" }
      },
      config = function()
        local climber = require('tree-climber')
        local keybind = require('utils').keybind

        keybind({ 'n', 'H', function()
          vim.cmd [[normal m']] -- add to jumplist
          climber.goto_parent()
        end })
        keybind({ 'n', 'L', climber.goto_child })
        keybind({ 'n', '<leader><C-K>', climber.swap_prev })
        keybind({ 'n', '<leader><C-J>', climber.swap_next })
      end
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
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
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

    use { -- Commentary
      'numToStr/Comment.nvim',
      config = function()
        local keybind = require("utils").keybind
        local comment = require('Comment.api')

        require('Comment').setup({
          ignore = '^$',
          mappings = false,
        })

        keybind({ 'n', { '<leader>/' }, comment.toggle_current_linewise })
        keybind({ 'x', { '<leader>/' },
          '<ESC><CMD>lua require("Comment.api").locked.toggle_linewise_op(vim.fn.visualmode())<CR>' })
      end
    }

    -- use { -- Github copilot
    --   'zbirenbaum/copilot-cmp',
    --   requires={
    --     'zbirenbaum/copilot.lua'
    --     -- 'github/copilot.vim'
    --   },
    --   after = {'nvim-cmp'},
    --   event = {"InsertEnter"},
    --   config = function()
    --     vim.schedule(function()
    --       require("copilot").setup {
    --         cmp_method = "getPanelCompletions",
    --       }
    --     end)
    --   end,
    -- }

  end
}
