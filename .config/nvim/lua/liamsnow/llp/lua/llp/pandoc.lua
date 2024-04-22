local M = {}

function M.call(buf, conf)
  -- read content from buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, '\n')
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t:r")

  -- grab args
  local pandoc_args = conf.args

  if (conf.inject_title) then
    pandoc_args = vim.list_extend({
      '-M', 'title=' .. filename .. ''
    }, pandoc_args)
  end

  -- spawn pandoc command
  -- Resources:
  --  - https://teukka.tech/vimloop.html
  --  - https://github.com/luvit/luv/blob/master/docs.md#uv_process_t--process-handle
  local stdin = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local handle
  handle = vim.loop.spawn("pandoc", {
      args = pandoc_args,
      stdio = { stdin, nil, stderr },
    },
    function(_, _)
      stderr:read_stop()
      stderr:close()
      handle:close()
    end
  )

  local err_str = ""

  vim.loop.read_start(stderr, function(err, data)
    assert(not err, err)
    if data then
      err_str = err_str .. data
    else
      if (err_str:len() > 2) then
        print("Pandoc Error:", err_str)
      end
    end
  end)

  -- write content to pandoc stdin
  vim.loop.write(stdin, content, function(err)
    assert(not err, err)
    vim.loop.shutdown(stdin)
  end)

  -- close standard input (confirm)
  vim.loop.shutdown(stdin, function()
    stderr:read_stop()
    stderr:close()
    handle:close()
  end)
end

return M
