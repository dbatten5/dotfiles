_G.dd = function(...)
  require("snacks").debug.inspect(...)
end
_G.bt = function()
  require("snacks").debug.backtrace()
end
_G.R = function(name)
  package.loaded[name] = nil
  return require(name)
end

if vim.fn.has("nvim-0.11") == 1 then
  vim._print = function(_, ...)
    dd(...)
  end
else
  vim.print = dd
end

require("config")
