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
    use {
      'nvim-neotest/neotest',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'janko-m/vim-test',
        'nvim-neotest/neotest-go',
        'nvim-neotest/neotest-plenary',
        'rouge8/neotest-rust',
        'nvim-neotest/neotest-vim-test',
      },
      config = function()
        local neotest = require('neotest')
        neotest.setup({
          adapters = {
            require('neotest-go'),
            require('neotest-rust'),
            require('neotest-plenary'),
            require('neotest-vim-test')({
              ignore_file_types = { "go" },
            }),
          }
        })

        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>tt', neotest.run.run }) -- nearest
        keybind({ 'n', '<leader>tf', function() return neotest.run.run(vim.fn.expand('%')) end }) -- file
        keybind({ 'n', '<leader>to', neotest.output.open }) -- file
        keybind({ 'n', '<leader>tr', neotest.summary.open }) -- file
        keybind({ 'n', '<leader>ts', '<cmd>TestSuite<CR>' }) -- suite
        keybind({ 'n', '<leader>tl', '<cmd>TestLast<CR>' }) -- last
        keybind({ 'n', '<leader>tv', '<cmd>TestVisit<CR>' }) -- visit
      end,
    }

    use { -- nvim-dap (debugger)
      'mfussenegger/nvim-dap',
      requires = {
        'rcarriga/nvim-dap-ui',
        'leoluz/nvim-dap-go',
        'theHamsta/nvim-dap-virtual-text',
      },
      config = function()
        local dap_virtual = require('nvim-dap-virtual-text')
        local dap, dapui = require('dap'), require('dapui')

        -- languages
        require('dap-go').setup()
        table.insert(dap.configurations.go, 1, {
          name = "Attach to Delve (localhost:4000)",
          type = "go",
          request = "attach",
          mode = "remote",
          port = 4000
        })

        -- configs
        dap_virtual.setup({})
        dapui.setup({
          layouts = {
            {
              elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 0.2,
              position = "left",
            },
            {
              elements = {
                "repl",
              },
              size = 0.25,
              position = "bottom",
            },
          },
          floating = {
            max_width = 0.8,
            border = "rounded"
          }
        })

        -- icons
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'debugBreakpoint' })

        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>dd', dap.toggle_breakpoint })
        keybind({ 'n', '<leader>dD', function() dap.set_breakpoint(vim.fn.input('Condition: ')) end })
        keybind({ 'n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Message: ')) end })
        keybind({ 'n', '<F5>', dap.continue })
        keybind({ 'n', '<F6>', function()
          dap.close()
          dapui.close({})
          dap_virtual.refresh()
        end })
        keybind({ 'n', '<F6><F6>', dap.clear_breakpoints })

        local temporary_keybinds = function()
          local cleaners = {}
          local k = function(...)
            table.insert(cleaners, keybind(...))
          end

          k({ 'n', '<leader><F5>', dap.restart })
          k({ { 'n', 'v' }, '<M-K>', dapui.eval })
          k({ 'n', '<leader>de', function() dapui.eval(vim.fn.input("Eval: ")) end })
          k({ 'n', '<leader>dt', dapui.toggle })
          k({ 'n', '<F8>', dap.step_over })
          k({ 'n', '<F6><F8>', dap.step_into })
          k({ 'n', '<F7>', dap.step_out })

          return function()
            for _, cleaner in ipairs(cleaners) do
              cleaner()
            end
          end
        end

        local cleanup_temporary_keybinds = function() end
        local cleanup_dap_buffers = function()
          local buffers = vim.api.nvim_list_bufs()

          local daps = vim.tbl_filter(function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            return vim.api.nvim_buf_is_valid(bufnr)
                and vim.api.nvim_buf_get_option(bufnr, 'buflisted')
                and string.match(bufname, "%[dap-.+%]")
          end, buffers)

          for _, value in ipairs(daps) do
            vim.api.nvim_buf_delete(value, { force = true })
          end
        end

        local on_close = function()
          require('dapui').close({})
          cleanup_temporary_keybinds()
          cleanup_dap_buffers()
        end

        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open({})
          cleanup_temporary_keybinds = temporary_keybinds()
        end
        dap.listeners.before.event_terminated['dapui_config'] = on_close
        dap.listeners.before.event_exited['dapui_config'] = on_close
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

        keybind({ 'n', { '<leader>/' }, comment.toggle.linewise.current })
        keybind({ 'x', { '<leader>/' },
          '<ESC><CMD>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())<CR>gv' })
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
