return {
  init = function(use)
    use {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      -- if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
      -- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
      build = ":AvanteBuild source=false",
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",      -- for providers='copilot'
        'MeanderingProgrammer/render-markdown.nvim',
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
      },
      config = function()
        local avante = require('avante')

        avante.setup {
          provider = 'copilot',
          system_prompt = [[
You are an excellent programming expert.
]],
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
            toggle = {
              default = "<leader>lt",
              debug = "<leader>ld",
              hint = "<leader>lh",
            },
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
  end
}
