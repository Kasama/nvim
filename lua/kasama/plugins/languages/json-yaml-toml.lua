return {
  init = function(use)
    use { 'b0o/SchemaStore.nvim', ft = { 'json', 'toml', 'yaml', 'jsonp' } }
    use { 'elzr/vim-json', ft = { 'json', 'jsonp', 'toml', 'yaml' } }
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
          }
        }
      }
    })

    setup_lsp('taplo', {})
  end
}
