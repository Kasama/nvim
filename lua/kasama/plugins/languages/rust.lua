return {
  only_if = function()
    return not (vim.fn.executable('rustc') == 0)
  end,
  init = function(use, mason_install)
    local rust_augroup = vim.api.nvim_create_augroup('RustConfig', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      group = rust_augroup,
      pattern = 'rust',
      command = "setlocal shiftwidth=4"
    })
    -- debugger for rust
    if (vim.fn.executable('unzip') == 1) then
      mason_install('codelldb')
    end

    -- use {
    --   'simrat39/rust-tools.nvim',
    --   ft = 'rust',
    --   config = function()
    --     local keybind = require('utils').keybind

    --     local rust_group = vim.api.nvim_create_augroup("RustConfigs", { clear = true })
    --     vim.api.nvim_create_autocmd(
    --       "FileType",
    --       {
    --         group = rust_group,
    --         pattern = {
    --           "rust",
    --         },
    --         callback = function()
    --           keybind({ 'n', '<F5>', function()
    --             local dap = require('dap')
    --             local rust = require('rust-tools')

    --             local status = dap.status()
    --             if status == "" then
    --               rust.debuggables.debuggables()
    --             else
    --               dap.continue()
    --             end
    --           end, { buffer = true } })
    --         end,
    --       }
    --     )
    --   end,
    -- }
    use {
      'mrcjkb/rustaceanvim',
      version = "^5",
      lazy = false,
    }

    use {
      'Saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      tag = "stable",
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('crates').setup({})
      end,
    }
  end,
  lsp = function(setup_lsp)
    local mason = require('mason-registry')
    local dap_cfg = {}

    local ok, corelldb = pcall(mason.get_package, 'codelldb')
    if ok then
      local codelldb_install_path = vim.env.MASON or vim.fn.stdpath('data') .. '/extension'
      local codelldb_path = codelldb_install_path .. '/adapter/codelldb'
      local liblldb_path = codelldb_install_path .. '/lldb/lib/liblldb.so'

      dap_cfg = {
        adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path)
      }
    end

    local local_lsp_config = {}
    local local_lsp_config_file = ".vim/ls-settings.json"
    if vim.fn.filereadable(local_lsp_config_file) == 1 then
      local lsp_config = vim.fn.json_decode(vim.fn.readfile(local_lsp_config_file))
      if lsp_config["rust-analyzer"] ~= nil then
        local_lsp_config = lsp_config["rust-analyzer"]
      end
    end

    local rust_analyzer_configs = vim.tbl_deep_extend('force', {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      checkOnSave = {
        -- default
        -- command = "check"
        command = "clippy",
      },
      procMacro = {
        enable = true
      },
      diagnostics = {
        disabled = { "unresolved-proc-macro" },
      },
    }, local_lsp_config)

    -- All possible configs are in https://github.com/mrcjkb/rustaceanvim/blob/master/lua/rustaceanvim/config/internal.lua#L86
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = {
          replace_builtin_hover = false,
        }
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = rust_analyzer_configs
        },
        dap = dap_cfg,
      }
    }
  end,
}
