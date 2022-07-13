return {
  init = function(use)
    use { -- vim notify
      'rcarriga/nvim-notify',
      config = function()
        local notify = require('notify')
        vim.notify = notify
        local keybind = require('utils').keybind

        keybind({ 'n', '<leader>nd', notify.dismiss })
      end
    }

    use { 'kyazdani42/nvim-web-devicons' }
    local highlight_yank = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = highlight_yank, pattern = '*',
      callback = function()
        vim.highlight.on_yank()
      end,
    })

    use { -- lualine
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        local code_actions = function()
          local ok, lightbulb = pcall(require, 'nvim-lightbulb')
          if ok then
            return lightbulb.get_status_text()
          else
            return ""
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
            lualine_x = { 'fileformat', 'encoding' },
            lualine_y = { 'diagnostics', code_actions },
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
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons',
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
      config = function() require("stabilize").setup() end
    }
  end
}
