local M = {}

function M.convert_to_pascal(text)
  local parts = vim.split(text, "_", { plain = true })
  for i, part in ipairs(parts) do
    parts[i] = part:sub(1, 1):upper() .. part:sub(2):lower()
  end
  return vim.fn.join(parts, "")
end

return M
