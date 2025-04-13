return {
  only_if = function()
    return (vim.fn.executable('iex') == 1)
  end,
  init = function(use)
    use {
      "elixir-tools/elixir-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local elixir = require("elixir")
        local elixirls = require("elixir.elixirls")

        elixir.setup {
          nextls = { enable = true },
          credo = {},
          elixirls = {
            enable = true,
            settings = elixirls.settings {
              dialyzerEnabled = false,
              enableTestLenses = false,
            },
            on_attach = function(client, bufnr)
              vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
              vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
              vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
            end,
          }
        }
      end
    }
  end,
  lsp = function(setup_lsp)
    setup_lsp('elixirls')
  end,
}
