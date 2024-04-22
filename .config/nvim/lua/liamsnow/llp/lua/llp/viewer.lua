local M = {}

local viewerHandle

function M.launch(conf)
  -- set env vars
  if conf.viewer.env then
    for _, env_var in ipairs(conf.viewer.env) do
      vim.loop.os_setenv(env_var[1], env_var[2])
    end
  end

  -- get file path
  local filepath = conf.file
  if conf.file_relative then
    filepath = vim.loop.cwd() .. '/' .. filepath
  end

  -- format args
  for i, str in ipairs(conf.viewer.args) do
    if str:find("%%file%%") then
      conf.viewer.args[i] = str:gsub("%%file%%", filepath)
    end
  end

  -- spawn instance
  viewerHandle = vim.loop.spawn(conf.viewer.cmd, {
      args = conf.viewer.args,
    },
    function()
      viewerHandle:close()
    end
  )
end

function M.close()
  if viewerHandle and not viewerHandle:is_closing() then
    viewerHandle:kill(15)
  end
end

return M
