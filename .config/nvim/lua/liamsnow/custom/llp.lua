--
-- LPP: Liam's Pandoc Preview
--

--
-- MY SETTING (FIXME)
--
local pandoc_path = vim.fn.stdpath('config') .. '/pandoc'

local nvim_cache_path = vim.fn.stdpath('cache')
local output_html_file = nvim_cache_path .. '/llp.html'
local output_pdf_file = nvim_cache_path .. '/llp.pdf'

local pandoc_extensions = table.concat({
  'hard_line_breaks',      -- respect new lines
  'mark',                  -- highlighting with ==
  'lists_without_preceding_blankline',
  'rebase_relative_paths', -- image links
  'emoji',                 -- emojis with :smile:
  'short_subsuperscripts', -- x^2 or O~2
  'wikilinks_title_after_pipe'
}, '+')

local pandoc_base_args = {
  '-f', 'markdown+' .. pandoc_extensions,
  '-s',
  '--preserve-tabs',
  '--wrap=preserve',
}

local pandoc_pdf_args = vim.list_extend({
  '-o', output_pdf_file,
  '--lua-filter', pandoc_path .. '/pdf.lua',
  '--template', pandoc_path .. '/pdf.tex',
  '-V', 'source-dir="' .. pandoc_path .. '"'
}, pandoc_base_args)

local pandoc_html_args = vim.list_extend({
  '-o', output_html_file,
  '--lua-filter', pandoc_path .. '/html.lua',
  '--template', pandoc_path .. '/html.html',
  '--mathjax'
}, pandoc_base_args)

--local pdf_viewer_cmd = "sioyek " .. output_file .. ".pdf"

--
-- CODE
--

local active_buffer = nil
local is_running = false
local llp_group = vim.api.nvim_create_augroup('llp', {})

--
-- PANDOC
--
local function call_pandoc_on_buffer(buf)
  -- read content from buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, '\n')
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t:r")

  local pandoc_args = vim.list_extend({
    '-M', 'title=' .. filename .. ''
  }, pandoc_html_args)

  --print(vim.inspect(pandoc_args))

  -- spawn pandoc command
  local stdin = vim.loop.new_pipe(false)
  local handle
  handle = vim.loop.spawn("pandoc", {
      args = pandoc_args,
      stdio = { stdin, nil, nil }
    },
    function(_, _)
      handle:close()
    end
  )

  -- write content to pandoc stdin
  vim.loop.write(stdin, content, function(err)
    assert(not err, err)
    vim.loop.shutdown(stdin)
  end)

  -- close standard input (confirm)
  vim.loop.shutdown(stdin, function()
    handle:close()
  end)
end

--
-- BUFFER HANDLING
--
local function on_buffer_update(_, buf)
  if (is_running and buf == active_buffer) then
    return call_pandoc_on_buffer(buf)
  end
end

local function attemp_attach_to_current_buffer()
  local buf = vim.api.nvim_get_current_buf()

  local is_main_editor = vim.bo[buf].buflisted and vim.bo[buf].buftype == ""
  local file_extension = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":e")
  local is_markdown_file = file_extension == "md"

  if is_main_editor and is_markdown_file and buf ~= active_buffer then
    -- attach
    active_buffer = buf
    vim.api.nvim_buf_attach(buf, false, {
      on_lines = on_buffer_update,
      on_reload = on_buffer_update
    })
    call_pandoc_on_buffer(buf)
  end
end

--
-- VIEWER
--

local function launch_viewer()
  local handle
  handle = vim.loop.spawn('live-server', {
      args = {
        '--quiet',
        '--browser=falkon',
        '--open=llp.html',
        '--watch=llp.html',
        '--wait=0'
      },
      cwd = nvim_cache_path
    },
    function()
      handle:close()
    end
  )
end

local function close_viewer()
  --vim.loop.close(live_server_handle)
  -- FIXME
  vim.fn.system("pkill -f live-server")
  vim.fn.system("killall falkon")
end

--
-- USER CONTROLS
--
local function start()
  is_running = true

  attemp_attach_to_current_buffer()

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    group = llp_group,
    callback = function()
      attemp_attach_to_current_buffer()
    end,
  })

  launch_viewer()
end

local function stop()
  is_running = false

  vim.api.nvim_clear_autocmds({ group = llp_group })

  close_viewer()
end

local function toggle()
  if is_running then
    stop()
  else
    start()
  end
end

local function output_once()
  -- TODO
end


--
-- MY KEYMAPS (FIXME)
--
vim.keymap.set("n", "<leader>l", toggle)

-- auto stop
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = stop
})


--
-- FOR DEBUGGING PANDOC (WILL IMPLENT BY DEFAULT EVENTUALLY)
--
-- Resources: https://teukka.tech/vimloop.html, https://github.com/luvit/luv/blob/master/docs.md#uv_process_t--process-handle
--
--  -- spawn pandoc command
--  local stdin = vim.loop.new_pipe(false)
--  local stdout = vim.loop.new_pipe(false)
--  local stderr = vim.loop.new_pipe(false)
--  local handle
--  handle = vim.loop.spawn("pandoc", {
--      args = pandoc_pdf_args,
--      stdio = { stdin, stdout, stderr },
--    },
--    function(_, _)
--     -- stdout:read_stop()
--     -- stderr:read_stop()
--     -- stdout:close()
--     -- stderr:close()
--      handle:close()
--    end
--  )
--
--  print("PANDOC OPENED", handle)
--
--  local out_str = ""
--  local err_str = ""
--
--  vim.loop.read_start(stdout, function(err, data)
--    assert(not err, err)
--    if data then
--      out_str = out_str .. data
--    else
--      print("stdout", out_str)
--    end
--  end)
--
--  vim.loop.read_start(stderr, function(err, data)
--    assert(not err, err)
--    if data then
--      err_str = err_str .. data
--    else
--      print("stderr", err_str)
--    end
--  end)
--
--  print("PANDOC WRITE")
--
--  -- write content to pandoc stdin
--  vim.loop.write(stdin, content, function(err)
--    assert(not err, err)
--    --stdin:shutdown
--    vim.loop.shutdown(stdin)
--  end)
--
--  -- close standard input (confirm)
--  vim.loop.shutdown(stdin, function()
--   -- stdout:read_stop()
--   -- stderr:read_stop()
--   -- stdout:close()
--   -- stderr:close()
--    handle:close()
--  end)
