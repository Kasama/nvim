return {
  init = function(use)
    use { 'b0o/SchemaStore.nvim', ft = { 'json', 'toml', 'yaml', 'jsonp' } }
    use { 'elzr/vim-json', ft = { 'json', 'jsonp', 'toml', 'yaml' } }
    use { 'cespare/vim-toml', lazy = false }
  end,
  lsp = function(setup_lsp)
    local json_schemas = require('schemastore').json.schemas()

    setup_lsp('jsonls', {
      settings = {
        json = {
          schemas = json_schemas,
          validate = { enable = true },
        }
      }
    })

    setup_lsp('yamlls', {
      settings = {
        yaml = {
          schemas = {
            ["kubernetes"] = "*.kube.yaml",
            ["http://json.schemastore.org/ansible-stable-2.5"] = "*playbook.yml",
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.y*l",
            ["/home/roberto/documents/work/gitlab-system-hooks/renderer_template.json"] = "*.tpl.*",
            ["/home/roberto/documents/work/ring-infrastructure-plugin-backend/src/bundle/spec/schemas/bundle_list_schema.json"] = "*.bundle.y*l",
          },
          schemaStore = {
            enable = true,
            url = "https://www.schemastore.org/api/json/catalog.json"
          },
          completion = true,
          hover = true,
          validate = true,
          format = {
            enable = true,
            singleQuote = true,
            bracketSpacing = true,
          },
          keyOrdering = false,
        },
        redhat = {
          telemetry = false
        }
      }
    })

    -- Workaround for yaml-language-server that retunrs text with &emsp; tags in them
    local function hover_wrapper(err, request, ctx, config)
      local bufnr, winnr = vim.lsp.handlers.hover(err, request, ctx, config)
      if (bufnr == nil or winnr == nil) then
        return
      end
      local contents = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      contents = vim.tbl_map(
        function(line)
          return string.gsub(line, "&emsp;", "")
        end,
        contents
      )
      vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
      vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
      vim.api.nvim_win_set_height(winnr, #contents)

      return bufnr, winnr
    end

    vim.lsp.handlers["textDocument/hover"] = hover_wrapper

    setup_lsp('taplo', {})
  end
}
