return {
  init = function(use)
    -- use {
    --   'ray-x/go.nvim',
    --   require = 'ray-x/guihua.lua', -- floating window support
    --   config = function()
    --     require('go').setup()
    --   end
    -- }

    local elm_augroup = vim.api.nvim_create_augroup('GoConfig', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      group = elm_augroup,
      pattern = '*.go',
      command = "setlocal noexpandtab"
    })
  end,
  lsp = function(setup_lsp)
    setup_lsp('gopls', {
      staticcheck = true,
      codelenses = {
        generate = true
      }
    })
    -- setup_lsp('golangci_lint_ls', {})
  end,
  snippets = function()
    local ls = require('luasnip')
    local s, i, t, d, f = ls.s, ls.insert_node, ls.text_node, ls.dynamic_node, ls.function_node
    local c = ls.choice_node
    -- local c = require('kasama.snippet-utils').choice_node_with_virtual_text
    local fmt = require('luasnip.extras.fmt').fmt
    local ts_utils = require('nvim-treesitter.ts_utils')
    local ts_locals = require('nvim-treesitter.locals')

    vim.treesitter.set_query(
      'go',
      'ClosestFuncReturnTypes',
      [[ [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ] ]]
    )
    local function_nodes = {
      ['function_declaration'] = true,
      ['method_declaration'] = true,
      ['func_literal'] = true,
    }

    local get_default_value_for_type = function(_type, info)

      local for_error = info and info.err_name
      local n = function(content, inff)
        if for_error then
          return t(content)
        else
          inff.index = inff.index + 1
          return i(inff.index, content)
        end
      end
      if _type == 'int' then
        return n("0", info)
      elseif _type == 'error' then
        if for_error then
          info.index = info.index + 1

          return ls.sn(info.index, {
            t 'fmt.Errorf("',
            i(1, string.format('error in %s', info.func_name)),
            t(string.format(': %%w", %s)', info.err_name)),
          })
        else
          return n('nil', info)
        end
      elseif _type == 'bool' then
        return n('false', info)
      elseif _type == 'string' then
        return n('""', info)
      elseif string.find(_type, '*', 1, true) then
        if for_error then
          return n('nil', info)
        else
          info.index = info.index + 2
          return c(info.index - 1, {
            ls.sn(info.index, { t '&', t(string.sub(_type, 2, #_type)), t '{', i(1), t '}' }),
            i(info.index)
          })
        end
      else
        info.index = info.index + 1
        return ls.sn(nil, { t(_type), t '{', i(1), t '}' })
      end
    end

    local go_return_type = function(info, value_for_type)
      local cursor_node = ts_utils.get_node_at_cursor()
      -- current treesitter scope, from more to less specific
      local scope = ts_locals.get_scope_tree(cursor_node, 0)

      local function_node -- get closest function node
      for _, node in pairs(scope) do
        if function_nodes[node:type()] then
          function_node = node
          break
        end
      end

      if function_node == nil then
        return {}
      end

      local node_name = vim.treesitter.get_node_text(function_node:named_child('name'), 0)
      if node_name ~= nil then
        info.func_name = node_name
      else
        info.func_name = "anonymous func"
      end

      local handlers = {
        ['parameter_list'] = function(node)
          local result = {}
          local count = node:named_child_count()
          for index = 0, count - 1 do
            table.insert(result, value_for_type(vim.treesitter.get_node_text(node:named_child(index), 0), info))
            if index ~= count - 1 then
              table.insert(result, t { ', ' })
            end
          end
          return result
        end,
        ['type_identifier'] = function(node)
          local text = vim.treesitter.get_node_text(node, 0)
          return { value_for_type(text, info) }
        end,
      }

      local query = vim.treesitter.get_query('go', 'ClosestFuncReturnTypes')
      for _, node in query:iter_captures(function_node, 0) do
        if handlers[node:type()] then
          return handlers[node:type()](node)
        end
      end
      return {}
    end

    local go_return_error = function(args)
      return ls.sn(
        nil,
        go_return_type({
          index = 0,
          err_name = args[1][1],
          func_name = 'test_func', -- args[2][1],
        }, get_default_value_for_type)
      )
    end

    local go_return_value = function()
      return ls.sn(
        nil,
        go_return_type({
          index = 0,
        }, get_default_value_for_type)
      )
    end

    -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/snips/ft/go.lua
    ls.add_snippets('go', {
      s('pack', fmt([[package {}]], { i(1) }, {})),
      s(
        'ife',
        {
          t 'if ', i(1, { 'err' }), t { ' != nil {', '\treturn ' },
          d(2, go_return_error, { 1 }), i(3),
          t { '', '}' }, i(0),
        }
      ),
      s('ret', { t 'return ', d(1, go_return_value, {}) }),
      s(
        'forr',
        {
          t 'for ', i(1, "i"), t ', ', i(2, "v"), t ' := range ', i(3, "variable"), t { ' {', '\t' },
          i(0),
          t { '', '}' }
        }
      ),
      s(
        'if',
        {
          t 'if ', i(1, "i"), t { ' {', '\t' },
          i(0),
          t { '', '}' }
        }
      ),
      s(
        'for',
        {
          t 'for ', i(1, "i"), t { ' {', '\t' },
          i(0),
          t { '', '}' }
        }
      )
    }, { key = 'go' })
  end,
}
