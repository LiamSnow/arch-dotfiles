local pandoc = require("llp.pandoc")

local llp_group = vim.api.nvim_create_augroup('llp', {})
local active_buffer = nil
local conf = nil

local M = {}

local function on_buffer_update(_, buf)
  if (buf == active_buffer) then
    return pandoc.call(buf, conf)
  end
end

local function attemp_attach_to_current_buffer()
  local buf = vim.api.nvim_get_current_buf()
  if buf ~= active_buffer then
    local file_extension = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":e")
    if file_extension == "md" then
      -- attach
      active_buffer = buf
      vim.api.nvim_buf_attach(buf, false, {
        on_lines = on_buffer_update,
        on_reload = on_buffer_update
      })
      pandoc.call(buf, conf)
    end
  end
end

function M.start(new_conf)
  conf = new_conf

  -- attach to current
  attemp_attach_to_current_buffer()

  -- follow when user switches buffer
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    group = llp_group,
    callback = attemp_attach_to_current_buffer
  })
end

function M.stop()
  active_buffer = nil
  vim.api.nvim_clear_autocmds({ group = llp_group })
  pandoc.stop()
end

return M
