local viewer = require("llp.viewer")
local buffer = require("llp.buffer")
local pandoc = require("llp.pandoc")

local running = false

local M = {}

function M.setup()
  running = false

  -- auto stop
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = M.stop
  })
end

function M.start(conf)
  running = true
  buffer.start(conf)
  viewer.launch(conf)
end

function M.stop()
  running = false
  buffer.stop();
  viewer.close()
end

function M.toggle(conf)
  if running then
    M.stop()
  else
    M.start(conf)
  end
end

return M
