return {
  init = function(use)
    use { -- vim notify
      'rcarriga/nvim-notify',
      lazy = false,
      config = function()
        local notify = require('notify')
        vim.notify = notify
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>nd', notify.dismiss })
      end
    }

    use { 'nvim-tree/nvim-web-devicons' }
    local highlight_yank = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = highlight_yank,
      pattern = '*',
      callback = function()
        vim.highlight.on_yank()
      end,
    })

    use { -- lualine
      'nvim-lualine/lualine.nvim',
      lazy = false,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        local status_from = function(package, func)
          return function()
            local ok, pkg = pcall(require, package)
            if ok then
              return pkg[func]()
            else
              return ""
            end
          end
        end
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = { { 'filename', file_status = true, path = 3 } },
            lualine_x = { status_from('dap', 'status'), 'fileformat', 'encoding' },
            lualine_y = { 'diagnostics', status_from('nvim-lightbulb', 'get_status_text') },
            lualine_z = {
              '%3p%% %l/%L☰ %-2v', -- percent through file; current line/total lines; current column
              { 'filetype', colored = false }
            },
          },
          tabline = {},
          extensions = {}
        }
      end
    }

    use { -- buffer line
      'akinsho/bufferline.nvim',
      version = "*",
      lazy = false,
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'navarasu/onedark.nvim',
      },
      config = function()
        require('bufferline').setup {
          options = {
            buffer_close_icon = '',
            show_close_icon = false,
            custom_filter = function(buf_number)
              -- filter out by buffer name
              -- vim.notify("filtering buffers: " .. vim.fn.bufname(buf_number))
              if vim.fn.bufname(buf_number) ~= "[dap-repl]" then
                return true
              end
            end
          },
        }
      end,
    }

    use { -- Stabilize window on split/popup/etc
      "luukvbaal/stabilize.nvim",
      event = 'VeryLazy',
      config = function() require("stabilize").setup() end
    }

    use { -- dressing (vim.ui.input)
      'stevearc/dressing.nvim',
      event = 'VeryLazy',
      config = function()
        require('dressing').setup({
          input = {
            enabled = true,
          },
          select = {
            enabled = false,
          },
        })
      end,
    }

    use { -- no-neck-pain (centralize buffer text)
      'shortcuts/no-neck-pain.nvim',
      event = 'VeryLazy',
      version = "*",
      config = function()
        -- values below are the default
        require("no-neck-pain").setup({
          -- the width of the focused buffer when enabling NNP.
          -- If the available window size is less than `width`, the buffer will take the whole screen.
          width = 120,
          -- prints useful logs about what event are triggered, and reasons actions are executed.
          debug = false,
          -- options related to the side buffers
          buffers = {
            left = NoNeckPain.bufferOptions,
            right = NoNeckPain.bufferOptions,
            -- if set to `true`, the side buffers will be named `no-neck-pain-left` and `no-neck-pain-right` respectively.
            showName = false,
            -- the buffer options when creating the buffer
            options = {
              bo = {
                filetype = "no-neck-pain",
                buftype = "nofile",
                bufhidden = "hide",
                modifiable = false,
                buflisted = false,
                swapfile = false,
              },
              wo = {
                cursorline = false,
                cursorcolumn = false,
                number = false,
                relativenumber = false,
                foldenable = false,
                list = false,
              },
            },
          },
        })
      end,
    }

    use {
      'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
      event = 'VeryLazy',
      config = function()
        local rainbow = require 'rainbow-delimiters'

        local setup_colors = function()
          vim.cmd [[
            highlight TSRainbowViolet ctermfg=13 guifg=#b452cd
            highlight TSRainbowOrange ctermfg=13 guifg=#FFB9B9
            highlight TSRainbowRose   ctermfg=13 guifg=#eeaeee
            highlight TSRainbowPink   ctermfg=13 guifg=#ff69b4
          ]]
        end

        setup_colors()

        require('rainbow-delimiters.setup').setup {
          strategy = {
            [''] = rainbow.strategy['global'],
            commonlisp = rainbow.strategy['local'],
            clojure = rainbow.strategy['local'],
            html = rainbow.strategy['local'],
          },

          query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
          },

          highlight = {
            "TSRainbowViolet",
            "TSRainbowOrange",
            "TSRainbowRose",
            "TSRainbowPink",
          },

          blacklist = {},
        }
      end,
    }
  end
}
