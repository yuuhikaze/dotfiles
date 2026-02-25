function Para(para)
    if #para.content == 1 and para.content[1].tag == 'RawInline' then
        local rawInline = para.content[1]
        if rawInline.format:match 'html' then
            local srcPattern = '<img%ssrc="([^"]+)".*/>'
            local scalePattern = '<img.*:%s?(%d+).*/>'
            local src = string.match(rawInline.text, srcPattern)
            local scale = string.match(rawInline.text, scalePattern)
            scale = scale / 100
            if src then
                local latexCode = string.format(
                    "\\begin{center}\n" ..
                    "\\includegraphics[width=%f\\textwidth]{%s}\n" ..
                    "\\end{center}", scale, src
                )
                return pandoc.RawBlock('latex', latexCode)
            end
        end
    end
end
