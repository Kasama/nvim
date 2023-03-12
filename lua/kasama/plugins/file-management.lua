return {
  init = function(use)
    use { -- nvim tree
      'kyazdani42/nvim-tree.lua',
      dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      version = 'nightly',              -- optional, updated every week. (see issue #1193)
      init = function()
        local keybind = require('utils').keybind
        keybind({ 'n', [[\]], '<cmd>NvimTreeFindFileToggle<CR>' })
      end,
      cmd = { 'NvimTreeFindFileToggle' },
      config = function()
        require('nvim-tree').setup {
          git = {
            enable = false,
          },
          renderer = {
            indent_markers = {
              enable = true,
            },
          },
          view = {
            mappings = {
              custom_only = true,
              list = {
                { key = { '<CR>', 'o', '<2-LeftMouse>' }, action = 'edit' },
                { key = '<C-e>',                          action = 'edit_in_place' },
                { key = 'O',                              action = 'edit_no_picker' },
                { key = { '<C-]>', '<2-RightMouse>' },    action = 'cd' },
                { key = '<C-v>',                          action = 'vsplit' },
                { key = '<C-x>',                          action = 'split' },
                { key = '<C-t>',                          action = 'tabnew' },
                { key = '<',                              action = 'prev_sibling' },
                { key = '>',                              action = 'next_sibling' },
                { key = 'P',                              action = 'parent_node' },
                { key = '<BS>',                           action = 'close_node' },
                { key = '<Tab>',                          action = 'preview' },
                { key = 'K',                              action = 'first_sibling' },
                { key = 'J',                              action = 'last_sibling' },
                { key = 'I',                              action = 'toggle_git_ignored' },
                { key = 'H',                              action = 'toggle_dotfiles' },
                { key = 'U',                              action = 'toggle_custom' },
                { key = 'R',                              action = 'refresh' },
                { key = { 'a', 'A' },                     action = 'create' },
                { key = 'd',                              action = 'remove' },
                { key = 'D',                              action = 'trash' },
                { key = 'r',                              action = 'rename' },
                { key = '<C-r>',                          action = 'full_rename' },
                { key = 'x',                              action = 'cut' },
                { key = { 'y' },                          action = 'copy' },
                { key = 'p',                              action = 'paste' },
                { key = 'c',                              action = 'copy_name' },
                { key = 'Y',                              action = 'copy_path' },
                { key = 'gy',                             action = 'copy_absolute_path' },
                { key = '[c',                             action = 'prev_git_item' },
                { key = ']c',                             action = 'next_git_item' },
                { key = '-',                              action = 'dir_up' },
                { key = 's',                              action = 'system_open' },
                { key = 'f',                              action = 'live_filter' },
                { key = 'F',                              action = 'clear_live_filter' },
                { key = 'q',                              action = 'close' },
                { key = 'W',                              action = 'collapse_all' },
                { key = 'E',                              action = 'expand_all' },
                { key = 'S',                              action = 'search_node' },
                { key = '.',                              action = 'run_file_command' },
                { key = 'K',                              action = 'toggle_file_info' },
                { key = 'g?',                             action = 'toggle_help' },
              },
            }
          }
        }
      end
    }
  end,
}
