local M = {}

local handle = nil
local stdin = nil
local stderr = nil
local err_str = ""

function M.call(buf, conf)
  -- read content from buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, '\n')
  local input_filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t:r")

  -- grab args
  local pandoc_args = conf.args

  if (conf.inject_title) then
    pandoc_args = vim.list_extend({
      '-M', 'title=' .. input_filename
    }, pandoc_args)
  end

  -- spawn pandoc command
  -- Resources:
  --  - https://teukka.tech/vimloop.html
  --  - https://github.com/luvit/luv/blob/master/docs.md#uv_process_t--process-handle
  stdin = vim.loop.new_pipe(false)
  stderr = vim.loop.new_pipe(false)
  handle = vim.loop.spawn("pandoc", {
      args = pandoc_args,
      stdio = { stdin, nil, stderr },
      cwd = vim.loop.cwd()
    },
    function(_, _)
      M.stop()
    end
  )

  err_str = ""

  vim.loop.read_start(stderr, function(err, data)
    assert(not err, err)
    if data then
      err_str = err_str .. data
    else
      M.stop()
    end
  end)

  -- write content to pandoc stdin
  vim.loop.write(stdin, content, function(err)
    assert(not err, err)
    vim.loop.shutdown(stdin)
  end)

  -- close standard input (confirm)
  vim.loop.shutdown(stdin, function()
    M.stop()
  end)
end

function M.print_error()
  if err_str and err_str:len() > 2 then
    print("Pandoc Error:", err_str)
  end
end

function M.stop()
  M.print_error()

  if stderr and not stderr:is_closing() then
    stderr:read_stop()
    stderr:close()
  end

  if stdin and not stdin:is_closing() then
    stdin:close()
  end

  if handle and not handle:is_closing() then
    handle:close()
  end
end

return M
