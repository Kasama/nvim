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
    use { 'machakann/vim-highlightedyank' }

    use { -- lualine
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {'filename'},
            lualine_x = {'fileformat', 'encoding'},
            lualine_y = {'diagnostics'},
            lualine_z = {'progress', 'location', 'filetype'},
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
          guifgs = {'MediumOrchid3', 'LightSalmon3', 'Plum2', 'HotPink'},
          separately = { liquid = 0 }
        }
      end
    }
  end
}
