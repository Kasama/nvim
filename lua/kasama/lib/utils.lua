local function keybind(mapping)
  local default_opts = { silent = true, noremap = true }

  local modes = mapping[1]
  local rhs = mapping[2]
  local lhs = mapping[3]
  local custom_opts = mapping[4] or {}
  local opts = default_opts

  for opt, val in pairs(custom_opts) do
    opts[opt] = val
  end

  if type(rhs) ~= 'table' then
    rhs = { rhs }
  end

  for _, keys in ipairs(rhs) do
    vim.keymap.set(modes, keys, lhs, opts)
  end

  return function() -- function to clear keymap
    local del_opts = {}
    if opts.buffer ~= nil then
      del_opts = { buffer = opts.buffer }
    end
    for _, keys in ipairs(rhs) do
      vim.keymap.del(modes, keys, del_opts)
    end
  end
end

----------- Table Functions -------------
local table_clone_internal
table_clone_internal = function(t, copies)
  if type(t) ~= "table" then return t end

  copies = copies or {}
  if copies[t] then return copies[t] end

  local copy = {}
  copies[t] = copy

  for k, v in pairs(t) do
    copy[table_clone_internal(k, copies)] = table_clone_internal(v, copies)
  end

  setmetatable(copy, table_clone_internal(getmetatable(t), copies))

  return copy
end

local table_clone
table_clone = function(t)
  -- We need to implement this with a helper function to make sure that
  -- user won't call this function with a second parameter as it can cause
  -- unexpected troubles
  return table_clone_internal(t)
end

local table_merge
table_merge = function(...)
  local tables_to_merge = { ... }
  assert(#tables_to_merge > 1, "There should be at least two tables to merge them")

  for k, t in ipairs(tables_to_merge) do
    assert(type(t) == "table", string.format("Expected a table as function parameter %d", k))
  end

  local result = table_clone(tables_to_merge[1])

  for i = 2, #tables_to_merge do
    local from = tables_to_merge[i]
    for k, v in pairs(from) do
      if type(v) == "table" then
        result[k] = result[k] or {}
        assert(type(result[k]) == "table", string.format("Expected a table: '%s'", k))
        result[k] = table_merge(result[k], v)
      else
        result[k] = v
      end
    end
  end

  return result
end
-------------------------------------------

local function maximum(a)
  local values = {}

  for k, v in pairs(a) do
    v = tonumber(v, 10) or 0
    if type(k) == "number" and type(v) == "number" then
      values[#values + 1] = v
    end
  end
  table.sort(values) -- automatically sorts lowest to highest

  return values[#values]
end

return {
  load_from_factory = function(basedir)
    local parent_dir = vim.fn.stdpath('config') .. '/' .. basedir
    package.path = package.path .. ';' .. parent_dir .. '/?.lua'
    return function(dir)
      local parts = parent_dir .. '/' .. dir .. '/*.lua'
      local loadees = vim.split(vim.fn.glob(parts), '\n')

      local loaded = {}
      for _, loadee in pairs(loadees) do
        local loadee_path = dir .. '.' .. vim.fn.fnamemodify(loadee, ':t:r')
        local required_loadee = require(loadee_path)
        table.insert(loaded, required_loadee)
      end

      return loaded
    end
  end,

  file_modified = function(filename)
    local age = vim.split(vim.fn.system({ "find", filename, "-type", "f", "-printf", '"%A@\n"' }):gsub("'", ''):gsub('"'
      , ''), '\n')

    local numberage = maximum(age)

    return numberage
  end,

  keybind = keybind,
  table_merge = table_merge,
  lists = require('lists'),
  fun = require('fun'),
}
