return {
  init = function(use)

    -- Tabularize command
    use { 'godlygeek/tabular' }

    use { -- Multiple cursors
      'mg979/vim-visual-multi',
    }
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_default_mappings = 0

    -- Grammar Check
    -- use { 'rhysd/vim-grammarous' }

    -- Lua.

    use({
      'sQVe/sort.nvim',

      -- Optional setup for overriding defaults.
      config = function()
        require("sort").setup({})
      end
    })

  end

}
