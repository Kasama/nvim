return {
  init = function(use)
    -- Simply the best git plugin around
    use { 'tpope/vim-fugitive' }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          attach_to_untracked = false,
        }
      end,
    }

    use { -- Permalink parts of the code
      'ruifm/gitlinker.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require('gitlinker').setup({
          mappings = '<Plug>gitlink',
          callbacks = {
            ["git.topfreegames.com"] = require('gitlinker.hosts').get_gitlab_type_url,
          }
        })
        vim.api.nvim_create_user_command(
          'GitLink',
          function(args)
            local linker = require('gitlinker')

            if args.range == 0 then
              return linker.get_buf_range_url('n')
            else
              return linker.get_buf_range_url('v')
            end
          end,
          { range = true }
        )
      end,
    }
  end
}
