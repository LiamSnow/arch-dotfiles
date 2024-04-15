return {
  {
    "frabjous/knap",
    config = function()
      local knap = require("knap")

      -- process once & refresh
      vim.keymap.set('n', '<leader>po', function() knap.process_once() end)

      -- close viewer
      vim.keymap.set('n', '<leader>pc', function() knap.close_viewer() end)

      -- toggle auto-processing
      vim.keymap.set('n', '<leader>pa', function() knap.toggle_autopreviewing() end)

      -- SyncTeX forward search
      vim.keymap.set('n', '<leader>ps', function() knap.forward_jump() end)

      local pandoc_path = vim.fn.stdpath('config') .. '/pandoc';

      vim.g.knap_settings = {
        mdoutputext = "pdf",
        mdtopdf = 'pandoc -f markdown -t pdf -s -o %outputfile% --lua-filter="'..pandoc_path..'/wpi.lua" --template="'..pandoc_path..'/wpi.tex" -V attachment-folder="'..pandoc_path..'"',
        mdtopdfviewerlaunch = "sioyek %outputfile%",
        mdtopdfviewerrefresh = "none",
        mdtopdfbufferasstdin = true
      }
    end
  }
}
