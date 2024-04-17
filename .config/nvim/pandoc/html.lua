-- Inject Title
--function Pandoc(doc)
--  if doc.meta and doc.meta.title then
--    local title = pandoc.utils.stringify(doc.meta.title)
--
--    if title then
--      local header = pandoc.Header(1, title)
--      local div = pandoc.Div({ header })
--      table.insert(doc.blocks, 1, div)
--    end
--  end
--
--  return doc
--end

return { {
  --Pandoc = Pandoc,
} }
