return {
  init = function(use)
    use {
      "nvim-neorg/neorg",
      lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
      version = "*", -- Pin Neorg to the latest stable release
      dependencies = {
        "folke/zen-mode.nvim"
      },
      config = function()
        require('neorg').setup {
          load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.presenter"] = {
              config = {
                zen_mode = "zen-mode"
              }
            },
            ["core.dirman"] = {
              config = {
                workspaces = {
                  notes = "/Files/ownCloud/org/norg/notes",
                  projects = "/Files/ownCloud/org/norg/projects",
                }
              }
            }
          }
        }
      end,
    }
  end,
}
