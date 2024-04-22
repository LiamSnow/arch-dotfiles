local viewer = require("llp.viewer")
local buffer = require("llp.buffer")
local pandoc = require("llp.pandoc")

local M = {}

function M.setup()
  vim.b.llp_running = false

  -- auto stop
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = M.stop
  })
end

function M.start(conf)
  vim.b.llp_running = true
  buffer.start(conf)
  viewer.launch(conf)
end

function M.stop()
  vim.b.llp_running = false
  buffer.stop();
  viewer.close()
end

function M.toggle(conf)
  if vim.b.llp_running then
    M.stop()
  else
    M.start(conf)
  end
end

return M
