return {
  {
    "llp",
    dir = "~/.config/nvim/lua/liamsnow/llp",
    config = function()
      local pandoc_path = vim.fn.stdpath('config') .. '/pandoc'
      local nvim_cache_path = vim.fn.stdpath('cache')
      local output_html_file = nvim_cache_path .. '/llp.html'
      local output_pdf_file = nvim_cache_path .. '/llp.pdf'

      local extensions = table.concat({
        'hard_line_breaks',      -- respect new lines
        'mark',                  -- highlighting with ==
        'lists_without_preceding_blankline',
        'rebase_relative_paths', -- image links
        'emoji',                 -- emojis with :smile:
        'short_subsuperscripts', -- x^2 or O~2
        'wikilinks_title_after_pipe'
      }, '+')

      local base_args = {
        '-f', 'markdown+' .. extensions,
        '-s',
        '--preserve-tabs',
        '--wrap=preserve',
      }

      local llp = require("llp")
      llp.setup()

      local html_config = {
        args = vim.list_extend({
          '-o', output_html_file,
          '--lua-filter', pandoc_path .. '/html.lua',
          '--template', pandoc_path .. '/html.html',
          '--mathjax'
        }, base_args),
        file = output_html_file,
        inject_title = true,
        viewer = {
          cmd = 'falkon',
          args = { '%file%' },
          env = {
            {
              "QTWEBENGINE_CHROMIUM_FLAGS",
              "--blink-settings=forceDarkModeEnabled=true"
            }
          }
        }
      }

      local pdf_config = {
        args = vim.list_extend({
          '-o', output_pdf_file,
          '--lua-filter', pandoc_path .. '/pdf.lua',
          '--template', pandoc_path .. '/pdf.tex',
          '-V', 'source-dir="' .. pandoc_path .. '"'
        }, base_args),
        file = output_pdf_file,
        inject_title = false,
        viewer = {
          cmd = 'sioyek',
          args = { '%file%' }
        }
      }

      vim.keymap.set("n", "<leader>l", function() llp.toggle(html_config) end)
    end
  }
}
