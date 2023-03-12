return {
  init = function(use)
    -- Simply the best git plugin around
    use { 'tpope/vim-fugitive', event = 'VeryLazy' }

    use {
      'lewis6991/gitsigns.nvim',
      lazy = false,
      config = function()
        require('gitsigns').setup {
          attach_to_untracked = false,
        }
      end,
    }

    use {
      'Kasama/git-worktree.nvim', -- fork of 'ThePrimeagen/git-worktree.nvim',
      branch = 'feature/switch-all-buffers',
      keys = '<leader>gw',
      config = function()
        local keybind = require('utils').keybind
        local ok, telescope = pcall(require, 'telescope')

        if ok then
          telescope.load_extension('git_worktree')
          keybind({ 'n', '<leader>gw', '<cmd>Telescope git_worktree git_worktrees<CR>' })
        end

        local worktree = require('git-worktree')

        worktree.reset()

        worktree.on_tree_change(function(op, metadata)
          if op == worktree.Operations.Switch then
            -- write desired change to trigger file
            os.execute(string.format('printf "%s\n%s" > /tmp/auto-dir-switch.cfg', metadata.prev_path, metadata.path))
            os.execute("for pid in $(pgrep zsh); do kill -USR2 $pid; done")

            local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
            if nvim_tree_ok then
              nvim_tree.change_dir(metadata.path)
            end
          end
        end)
      end,
    }

    use { -- Permalink parts of the code
      'ruifm/gitlinker.nvim',
      dependencies = 'nvim-lua/plenary.nvim',
      cmd = "GitLink",
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
