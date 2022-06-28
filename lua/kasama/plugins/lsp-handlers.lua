local M = {}

local redraw = function()
  vim.cmd [[normal! zz]]
end

M.implementations = function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config, ...)
    local bufnr = ctx.bufnr
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')

    if ft == 'go' then
      local new_result = vim.tbl_filter(function(v) return not string.find(v.uri, 'mock_') end, result)

      if #new_result > 0 then
        result = new_result
      end
    end

    vim.lsp.handlers["textDocument/implementation"](err, result, ctx, config, ...)

    redraw()
  end)
end

return M
