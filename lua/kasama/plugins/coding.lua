return {
  init = function(use)
    -- must have surround
    use { 'tpope/vim-surround', event = "InsertEnter" }

    -- live scratchpad
    use { 'metakirby5/codi.vim', cmd = 'Codi' }

    use { -- Treesitter
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      dependencies = { -- plugins
        'nvim-treesitter/playground',
        -- 'nvim-treesitter/nvim-treesitter-context',
        -- 'haringsrob/nvim_context_vt', -- Show virtual text with current context
      },
      lazy = false,
      config = function()
        -- Treesitter Config
        require('nvim-treesitter.configs').setup {
          ensure_installed = {
            'bash', 'c', 'clojure', 'cpp', 'css', 'dockerfile', 'eex', 'elixir', 'elm', 'gleam', 'go',
            'haskell', 'heex', 'hcl', 'html', 'java', 'javascript', 'json', 'json5', 'lua', 'make', 'ocaml',
            'ocaml_interface', 'python', 'query', 'regex', 'ruby', 'rust', 'scss', 'svelte', 'templ',
            'toml', 'tsx', 'typescript', 'yaml',
          },

          highlight = { enable = true },
          indent = { enable = true },

          playground = {
            enable = true,
            disable = {},
            updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
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
        }

        -- require('treesitter-context').setup({
        --   max_lines = 3,
        -- })

        -- FIX for rust SQL highlight injection
        vim.treesitter.query.set('rust', 'injections', [[
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
      dependencies = {
        { "nvim-treesitter/nvim-treesitter" }
      },
      init = function()
        local keybind = require('utils').keybind

        keybind({ 'n', 'H', function()
          vim.cmd [[normal m']] -- add to jumplist
          require('tree-climber').goto_parent()
        end })
        keybind({ 'n', 'L', require('tree-climber').goto_child })
        keybind({ 'n', '<leader><C-K>', require('tree-climber').swap_prev })
        keybind({ 'n', '<leader><C-J>', require('tree-climber').swap_next })
      end
    }

    use { -- auto pairs
      'altermo/ultimate-autopair.nvim',
      event = 'InsertEnter',
      config = function()
        require('ultimate-autopair').setup({
          cr = {
            addsemi = {}
          }
        })
      end,
    }

    vim.cmd [[let test#strategy = 'neovim']]
    use { -- Neotest
      'nvim-neotest/neotest',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'janko-m/vim-test',
        'nvim-neotest/neotest-go',
        'nvim-neotest/neotest-plenary',
        'rouge8/neotest-rust',
        'nvim-neotest/neotest-vim-test',
        'nvim-neotest/neotest-python',
      },
      init = function()
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>tt', function() require('neotest').run.run() end })                          -- nearest
        keybind({ 'n', '<leader>tf', function() return require('neotest').run.run(vim.fn.expand('%')) end }) -- file
        keybind({ 'n', '<leader>to', function() require('neotest').output.open() end })                      -- file
        keybind({ 'n', '<leader>tr', function() require('neotest').summary.open() end })                     -- file
        keybind({ 'n', '<leader>ts', '<cmd>TestSuite<CR>' })                                                 -- suite
        keybind({ 'n', '<leader>tl', '<cmd>TestLast<CR>' })                                                  -- last
        keybind({ 'n', '<leader>tv', '<cmd>TestVisit<CR>' })                                                 -- visit
      end,
      cmd = {
        'TestSuite',
        'TestLast',
        'TestVisit',
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
            require('neotest-python'),
          }
        })
      end,
    }

    use { -- nvim-dap (debugger)
      'mfussenegger/nvim-dap',
      dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'leoluz/nvim-dap-go',
        'theHamsta/nvim-dap-virtual-text',
      },
      init = function()
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>dd', function() require('dap').toggle_breakpoint() end })
        keybind({ 'n', '<leader>dD', function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end })
        keybind({ 'n', '<leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Message: ')) end })
        keybind({ 'n', '<F5>', function() require('dap').continue() end })
        keybind({ 'n', '<F6>', function()
          require('dap').terminate()
          require('dapui').close({})
          require('nvim-dap-virtual-text').refresh()
        end })
        keybind({ 'n', '<F6><F6>', function() require('dap').clear_breakpoints() end })
      end,
      config = function()
        local dap_virtual = require('nvim-dap-virtual-text')
        local dap, dapui = require('dap'), require('dapui')

        dap.adapters.delve_remote = {
          type = "server",
          port = "4000",
          options = {
            initialize_timeout_sec = "20",
          },
        }

        -- languages
        require('dap-go').setup {
          delve = {},
        }

        table.insert(dap.configurations.go, 1, {
          name = "Attach to Delve (localhost:" .. dap.adapters.delve_remote.port .. ")",
          type = "delve_remote",
          request = "attach",
          mode = "remote",
          port = tonumber(dap.adapters.delve_remote.port)
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
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '󰋗', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DapLogPoint', { text = '󰵚', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'debugBreakpoint' })

        local keybind = require('utils').keybind

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

        local cleanup_temporary_keybinds = function()
        end
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
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
      },
      keys = { '<leader>rf' },
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
      init = function()
        local keybind = require("utils").keybind

        keybind({ 'n', { '<leader>/' }, function() require('Comment.api').toggle.linewise.current() end })
        keybind({ 'x', { '<leader>/' },
          '<ESC><CMD>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())<CR>gv' })
      end,
      config = function()
        require('Comment').setup({
          ignore = '^$',
          mappings = false,
        })
      end
    }

    use {
      'Wansmer/sibling-swap.nvim',
      init = function()
        local keybind = require("utils").keybind

        keybind({ 'n', '<leader><', function() require('sibling-swap').swap_with_left() end })
        keybind({ 'n', '<leader>>', function() require('sibling-swap').swap_with_right() end })
      end,
      dependencies = { 'nvim-treesitter' },
      config = function()
        require('sibling-swap').setup {
          use_default_keymaps = false
        }
      end
    }

    -- better quickfix window
    -- use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    -- use { -- Github copilot
    --   'zbirenbaum/copilot-cmp',
    --   dependencies={
    --     'zbirenbaum/copilot.lua'
    --     -- 'github/copilot.vim'
    --     'nvim-cmp',
    --   },
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
