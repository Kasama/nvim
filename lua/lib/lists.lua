local function identity(a)
  return a
end

--- reduce
---@param list table array of elements
---@param reducer function(existing, next, index): new_value
---@param initial initial value for the reducer
---@return element returned by the reducer
local function reduce(list, reducer, initial)
  local result = initial

  for i, val in ipairs(list) do
    result = reducer(result, val, i)
  end
  return result
end

local function first(list)
  return reduce(list, identity)
end

local all
all = function(list, ...)
  local predicates = {...}
  local initial = true
  return reduce(
    list,
    function(prev, next, _)
      if #predicates == 1 then
        return prev and first(predicates)(next)
      else
        return prev and all(predicates, function(f) return f(next) end)
      end
    end,
    initial
  )
end

local any
any = function(list, ...)
  local predicates = {...}
  local initial = false
  return reduce(
    list,
    function(prev, next, _)
      if #predicates == 1 then
        return prev or first(predicates)(next)
      else
        return prev or any(predicates, function(f) return f(next) end)
      end
    end,
    initial
  )
end

--- filter
---@param list table array of elements
---@param predicates function(existing, next, index): new_value
---@param initial initial value for the reducer
---@return element returned by the reducer
local function filter(list, ...)
  local result = {}
  local predicates = {...}

  for _, value in ipairs(list) do
    if all(list, predicates) then
      table.insert(result, value)
    end
  end

  return result
end

return {
  reduce = reduce,
  all = all,
  filter = filter,
}
