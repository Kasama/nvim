local M = {}

local ls = require('luasnip')
local f = ls.function_node
local c = ls.choice_node

M.same = function(index)
  return f(function(args)
    return args[1]
  end, { index })
end

local function node_with_virtual_text(pos, node, text)
  local types = require('luasnip.util.types')
  local events = require('luasnip.util.events')
  local sn, i = require('luasnip').snippet_node, require('luasnip').insert_node
  local nodes

  if node.type == types.textNode then
    node.pos = 2
    nodes = { i(1), node }
  else
    node.pos = 1
    nodes = { node }
  end
  return sn(pos, nodes, {
    callbacks = {
      -- node has pos 1 inside the snippetNode.
      [1] = {
        [events.enter] = function(nd)
          -- node_pos: {line, column}
          local node_pos = nd.mark:pos_begin()
          -- reuse luasnips namespace, column doesn't matter, just 0 it.
          nd.virt_text_id = vim.api.nvim_buf_set_extmark(0, ls.session.ns_id, node_pos[1], 0, {
            virt_text = { { text, "helpExample" } },
          })
        end,
        [events.leave] = function(nd)
          vim.api.nvim_buf_del_extmark(0, ls.session.ns_id, nd.virt_text_id)
        end,
      },
    },
  })
end

local function nodes_with_virtual_text(nodes, opts)
  if opts == nil then
    opts = {}
  end
  local new_nodes = {}
  for pos, node in ipairs(nodes) do
    if opts.texts and opts.texts[pos] ~= nil then
      node = node_with_virtual_text(pos, node, opts.texts[pos])
    end
    table.insert(new_nodes, node)
  end
  return new_nodes
end


M.node_with_virtual_text = node_with_virtual_text
M.nodes_with_virtual_text = nodes_with_virtual_text
M.choice_node_with_virtual_text = function(pos, choices, opts)
  --choices = nodes_with_virtual_text(choices, opts)
  return c(pos, choices, opts)
end

return M
