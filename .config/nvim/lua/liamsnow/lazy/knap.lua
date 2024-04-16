return {
  {
    "frabjous/knap",
    config = function()
      local knap = require("knap")

      -- stop
      local function stop_knap()
        knap.close_viewer()
        vim.fn.system("pkill -f live-server")
        vim.fn.system("killall falkon")
      end

      -- start HTML preview
      vim.keymap.set('n', '<leader>kh', function()
        vim.g.knap_settings.mdoutputext = "html"
        knap.toggle_autopreviewing()
      end)

      -- start PDF preview
      vim.keymap.set('n', '<leader>kp', function()
        vim.g.knap_settings.mdoutputext = "pdf"
        knap.toggle_autopreviewing()
      end)

      -- stop
      vim.keymap.set('n', '<leader>kk', function()
        stop_knap()
      end)

      -- auto stop
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = stop_knap
      })

      -- settings
      local pandoc_path = vim.fn.stdpath('config') .. '/pandoc'
      local md_to_pdf_path = pandoc_path .. '/liams_md_to_pdf'
      local md_to_html_path = pandoc_path .. '/liams_md_to_html'

      local pandoc_extensions = table.concat({
        "hard_line_breaks",      -- respect new lines
        "mark",                  -- highlighting with ==
        "lists_without_preceding_blankline",
        "rebase_relative_paths", -- image links
        "emoji",                 -- emojis with :smile:
        "short_subsuperscripts", -- x^2 or O~2
        "wikilinks_title_after_pipe"
      }, "+")

      local pandoc_base_cmd = table.concat({
        "pandoc",
        "-f markdown+" .. pandoc_extensions,
        "-s",
        "-o %outputfile%",
        "--preserve-tabs=true",
        "--wrap=preserve"
      }, " ")

      local pandoc_pdf_cmd = table.concat({
        pandoc_base_cmd,
        "-t pdf",
        '--lua-filter="' .. md_to_pdf_path .. '.lua"',
        '--template="' .. md_to_pdf_path .. '.tex"',
        '-V source-dir="' .. pandoc_path .. '"'
      }, " ")

      local pandoc_html_cmd = table.concat({
        pandoc_base_cmd,
        '--template="' .. md_to_html_path .. '.html"',
        '--mathjax',
      }, " ")


      vim.g.knap_settings = {
        mdtopdf = pandoc_pdf_cmd,
        mdtopdfviewerlaunch = "sioyek %outputfile%",
        mdtopdfviewerrefresh = "none",
        mdtopdfbufferasstdin = true,

        mdtohtml = pandoc_html_cmd,
        mdtohtmlviewerlaunch = "live-server --quiet --browser=falkon --open=%outputfile% --watch=%outputfile% --wait=0",
        mdtohtmlviewerrefresh = "none",
        mdtohtmlbufferasstdin = true,
      }
    end
  }
}
--local function kill_live_servers()
--  vim.fn.system("pkill -f live-server")
--end
-- process once & refresh
-- vim.keymap.set('n', '<leader>po', function() knap.process_once() end)
-- SyncTeX forward search
-- vim.keymap.set('n', '<leader>ps', function() knap.forward_jump() end)
