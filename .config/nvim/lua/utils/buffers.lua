local M = {}

---@class Buffer
---@field bufnr integer the buffer number
---@field file_path string the buffer file path
---@field file_type string the buffer file type

--- Return a list of other active buffers
---@param by_filetype? string filter by buffers that match this filetype
---@return table<Buffer> a list of active buffers that aren't the current one
function M.get_other_active_buffers(by_filetype)
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  local active_other_buffers = {}
  for _, buf in ipairs(buffers) do
    if buf ~= current_buf then
      local file_type = vim.api.nvim_get_option_value("filetype", { buf = buf })
      if by_filetype and (file_type ~= by_filetype) then
        goto continue
      end

      local is_listed = vim.api.nvim_get_option_value("buflisted", { buf = buf })
      local is_displayed = vim.fn.bufwinnr(buf) ~= -1
      local file_path = vim.api.nvim_buf_get_name(buf)
      if file_path and is_listed and is_displayed then
        table.insert(active_other_buffers, {
          bufnr = buf,
          file_path = file_path,
          file_type = vim.api.nvim_get_option_value("filetype", { buf = buf }),
        })
      end

      ::continue::
    end
  end
  return active_other_buffers
end

return M
