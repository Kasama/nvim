return {
  init = function(use)
    use { -- vim notify
      'rcarriga/nvim-notify',
      config = function()
        local notify = require('notify')
        vim.notify = notify
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
            lualine_y = { 'diagnostics' },
            lualine_z = {
              '%3p%% :%l/%L☰ :%-2v', -- percent through file; current line/total lines; current column
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
          },
        }
      end,
    }

    use { -- rainbow parens
      'luochen1990/rainbow',
      config = function()
        vim.g.rainbow_active = 1
        vim.g.rainbow_conf = {
          guifgs = { 'MediumOrchid3', 'LightSalmon3', 'Plum2', 'HotPink' },
          separately = { liquid = 0 }
        }
      end
    }
  end
}
