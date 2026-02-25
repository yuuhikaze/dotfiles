-- Lua Pandoc filter to convert <br> tag to a hard line break
function RawInline(raw)
    if raw.format:match 'html' then
        local pattern = '<br.*>'
        if string.match(raw.text, pattern) then
            return pandoc.LineBreak()
        end
    end
end
