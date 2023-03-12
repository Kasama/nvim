return {
  init = function(use)
    -- Tabularize command
    use { 'godlygeek/tabular', cmd = 'Tabularize' }

    use { -- Multiple cursors
      'mg979/vim-visual-multi',
      keys = { 'C-n' }
    }
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_default_mappings = 0

    -- Grammar Check
    -- use { 'rhysd/vim-grammarous' }

    -- Lua.

    use({
      'sQVe/sort.nvim',
      -- Optional setup for overriding defaults.
      cmd = 'Sort',
      config = function()
        require("sort").setup({})
      end
    })
  end
}
