return {
  only_if = function()
    return not (vim.fn.executable('arduino-cli') == 0)
  end,
  init = function(use, mason_install)
  end,
  lsp = function(setup_lsp)
    local keybind = require('utils').keybind

    local asyncrun = function(command, autoclose)
      return function()
        if autoclose == nil then
          autoclose = true
        end
        local arduino_upload = vim.api.nvim_create_augroup('ArduinoUpload', { clear = true })
        vim.api.nvim_create_autocmd(
          "User",
          {
            group = arduino_upload,
            pattern = 'AsyncRunPre',
            callback = function()
              vim.cmd("w | copen | wincmd p")
            end,
          })
        vim.api.nvim_create_autocmd(
          "User",
          {
            group = arduino_upload,
            pattern = 'AsyncRunStop',
            callback = function()
              local no_errors = vim.g.asyncrun_code == 0
              if autoclose and no_errors then
                vim.cmd("cclose")
              end
              vim.api.nvim_del_augroup_by_id(arduino_upload)
            end,
          })
        vim.cmd("AsyncRun " .. command)
      end
    end

    keybind({ "n", "<leader>ac", asyncrun("arduino-cli compile") })
    keybind({ "n", "<leader>au", asyncrun("arduino-cli compile -u") })

    keybind({ "n", "<leader>sm", function()
      if vim.fn.executable('picocom') == 1 then
        vim.cmd("botright | terminal arduino-cli monitor")
      else
        vim.notify("picocom is not installed", vim.log.levels.ERROR)
      end
    end })

    local caps = vim.lsp.protocol.make_client_capabilities()
    -- Arduino language server does not support semantic tokens
    caps.textDocument.semanticTokens = vim.NIL
    caps.workspace.semanticTokens = vim.NIL

    setup_lsp("arduino_language_server", {
      cmd = { "arduino-language-server", "-cli", "arduino-cli-0-35" },
      capabilities = caps,
    })
  end,
}
