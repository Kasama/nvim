return {
  only_if = function()
    local handle = io.popen("hostname")
    local hostname = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return hostname == "Kasama"
  end,
  init = function(use)
    if (vim.fn.executable('npm') == 1 and vim.fn.executable('mcp-hub') == 1) then
      use {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        event = "VeryLazy",
        -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
        build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        config = function()
          require("mcphub").setup({
            -- Required options
            port = 2837,                                 -- Port for MCP Hub server
            config = vim.fn.expand("~/mcpservers.json"), -- Absolute path to config file

            -- Optional options
            on_ready = function(hub)
              -- Called when hub is ready
            end,
            on_error = function(err)
              -- Called on errors
            end,
            log = {
              level = vim.log.levels.WARN,
              to_file = false,
              file_path = nil,
              prefix = "MCPHub"
            },
          })
        end
      }
    end
    use {
      "yetone/avante.nvim",
      cond = function() return vim.fn.executable('node') == 1 end,
      event = "VeryLazy",
      lazy = false,
      -- if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
      -- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
      build = "make",
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",      -- for providers='copilot'
        'MeanderingProgrammer/render-markdown.nvim',
        -- {
        --   -- support for image pasting
        --   "HakonHarnes/img-clip.nvim",
        --   event = "VeryLazy",
        --   opts = {
        --     -- recommended settings
        --     default = {
        --       embed_image_as_base64 = false,
        --       prompt_for_file_name = false,
        --       drag_and_drop = {
        --         insert_mode = true,
        --       },
        --       -- required for Windows users
        --       use_absolute_path = true,
        --     },
        --   },
        -- },
      },
      config = function()
        local avante = require('avante')

        local provider = 'gemini'

        local has_copilot, _copilot = pcall(require, 'copilot')
        if has_copilot then
          local config = vim.fn.expand("~/.config")
          local Path = require('plenary.path')
          local paths = vim.iter({ "hosts.json", "apps.json" }):fold({}, function(acc, path)
            local copilot_config_path = Path:new(config):joinpath("github-copilot", path)
            if copilot_config_path:exists() then table.insert(acc, copilot_config_path) end
            return acc
          end)
          local is_copilot_setup = #paths > 0

          if is_copilot_setup then
            provider = 'copilot'
          end
        end

        avante.setup {
          provider = provider,
          opts = {
            provider = 'gemini',
            gemini = {
              api_key_name = 'GEMINI_API_KEY',
              model = 'gemini-2.5-pro-exp-03-25',
            },
          },
          providers = {
            ['openrouter-gemini'] = {
              __inherited_from = 'openai',
              endpoint = 'https://openrouter.ai/api/v1',
              api_key_name = 'OPENROUTER_API_KEY',
              model = 'google/gemini-2.5-pro-exp-03-25:free',
              -- model = 'deepseek/deepseek-r1-zero:free',
              -- model = 'google/gemini-2.0-pro-exp-02-05:free',
              -- model = 'mistralai/mistral-small-3.1-24b-instruct:free',
            },
            ['openrouter-mistral'] = {
              __inherited_from = 'openai',
              endpoint = 'https://openrouter.ai/api/v1',
              api_key_name = 'OPENROUTER_API_KEY',
              -- model = 'google/gemini-2.5-pro-exp-03-25:free',
              -- model = 'deepseek/deepseek-r1-zero:free',
              -- model = 'google/gemini-2.0-pro-exp-02-05:free',
              model = 'mistralai/mistral-small-3.1-24b-instruct:free',
            }
          },
          system_prompt = function()
            local hub_exists, mcphub = pcall(require, 'mcphub')
            if hub_exists then
              local hub = mcphub.get_hub_instance()
              return hub:get_active_servers_prompt()
            else
              return "You are an excellent programming expert."
            end
          end,
          custom_tools = function()
            local hub_exists, avante_extension = pcall(require, 'mcphub.extensions.avante')
            if hub_exists then
              return {
                avante_extension.mcp_tool()
              }
            else
              return {}
            end
          end,
          behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
          },
          mappings = {
            --- @class AvanteConflictMappings
            diff = {
              ours = "co",
              theirs = "ct",
              all_theirs = "ca",
              both = "cb",
              cursor = "cC",
              next = "]x",
              prev = "[x",
            },
            suggestion = {
              accept = "<M-l>",
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
            jump = {
              next = "]]",
              prev = "[[",
            },
            submit = {
              normal = "<CR>",
              insert = "<C-s>",
            },
            ask = "<leader>la",
            edit = "<leader>le",
            refresh = "<leader>lr",
            focus = "<leader>lf",
            stop = "<leader>lS",
            toggle = {
              default = "<leader>lt",
              debug = "<leader>ld",
              hint = "<leader>lh",
              suggestion = "<leader>ls",
              repomap = "<leader>lR",
            },
            files = {
              add_current = "<leader>lc",
              add_all_buffers = "<leader>lB",
            },
            select_model = "<leader>l?",
            select_history = "<leader>lH",
          },
          hints = { enabled = false },
          windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right", -- the position of the sidebar
            wrap = true,        -- similar to vim.o.wrap
            width = 30,         -- default % based on available width
            sidebar_header = {
              align = "center", -- left, center, right for title
              rounded = true,
            },
          },
          highlights = {
            ---@type AvanteConflictHighlights
            diff = {
              current = "DiffText",
              incoming = "DiffAdd",
            },
          },
          --- @class AvanteConflictUserConfig
          diff = {
            autojump = true,
            ---@type string | fun(): any
            list_opener = "copen",
          },
        }

        vim.keymap.set("n", "<leader>lcc", "<CMD>AvanteClear<CR>")
        vim.keymap.set("i", "<C-X><C-L>", function()
          local api = vim.api
          local avante_utils = require("avante.utils")
          local avante_llm = require('avante.llm')

          avante_utils.debug("suggesting")

          local doc = avante_utils.get_doc()

          local bufnr = api.nvim_get_current_buf()
          local filetype = api.nvim_get_option_value("filetype", { buf = bufnr })
          local code_content =
              avante_utils.prepend_line_number(table.concat(api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") ..
                "\n\n")

          local full_response = ""

          avante_llm.stream({
            bufnr = bufnr,
            ask = true,
            file_content = code_content,
            code_lang = filetype,
            instructions = vim.json.encode(doc),
            mode = "suggesting",
            on_chunk = function(chunk) full_response = full_response .. chunk end,
            on_complete = function(err)
              if err then
                avante_utils.error("Error while suggesting: " .. vim.inspect(err), { once = true, title = "Avante" })
                return
              end
              avante_utils.debug("full_response: " .. vim.inspect(full_response))
              local cursor_row, cursor_col = avante_utils.get_cursor_pos()
              if cursor_row ~= doc.position.row or cursor_col ~= doc.position.col then return end
              local ok, suggestions = pcall(vim.json.decode, full_response)
              if not ok then
                avante_utils.error("Error while decoding suggestions: " .. full_response,
                  { once = true, title = "Avante" })
                return
              end
              if not suggestions then
                avante_utils.info("No suggestions found", { once = true, title = "Avante" })
                return
              end
              suggestions = vim
                  .iter(suggestions)
                  :map(function(s)
                    return {
                      row = s.row,
                      col = s.col,
                      content = avante_utils.trim_all_line_numbers(s.content)
                    }
                  end)
                  :totable()

              local items = vim.tbl_map(function(s)
                return { label = s.content:sub(1, 40), insertText = s.content }
              end, suggestions)

              vim.fn.complete(cursor_col + 1, items)
            end,
          })
        end)
      end,
    }
    use {
      "zbirenbaum/copilot.lua",
      cond = function() return vim.fn.executable('node') == 1 end,
      config = function()
        local copilot = require("copilot")
        local suggestion = require("copilot.suggestion")
        copilot.setup {
          panel = { enabled = false },
          suggestion = { enabled = false },
          filetypes = {
            sh = function()
              if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                -- disable for .env files
                return false
              end
              return true
            end,
          },
        }
        local utils = require("kasama.lib.utils")
        utils.keybind({ 'i', '<C-x><C-x>', function()
          suggestion.next()
        end })
      end
    }
  end
}
