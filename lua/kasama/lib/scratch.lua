local inspect = require('inspect')

local fun = require('fun')

local val = fun.any(function(x) return x < 0 end, {1,2,3,4})

print(val)

