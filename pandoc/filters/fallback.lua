local system = require 'pandoc.system'

local standalone_template = [[
\documentclass{standalone}
\usepackage{xcolor, tabularray}
\usepackage{tikz, pgfplots}
\begin{document}
\nopagecolor
%s
\end{document}
]]

local function tabularray2image(src, filetype)
    return system.with_temporary_directory('tabularray2image', function(tmpdir)
        return system.with_working_directory(tmpdir, function()
            local texfile = 'temp.tex'
            local pdffile = 'temp.pdf'
            local outfile = 'output.' .. filetype

            local f = io.open(texfile, 'w')
            if not f then
                io.stderr:write("Failed to create " .. texfile .. "\n")
                return nil
            end
            f:write(standalone_template:format(src))
            f:close()

            local success, _, _ = os.execute('pdflatex -interaction=nonstopmode ' .. texfile)
            if not success then
                io.stderr:write("Failed to compile LaTeX\n")
                return nil
            end

            if filetype == 'pdf' then
                os.rename(pdffile, outfile)
            else
                success, _, _ = os.execute('pdf2svg ' .. pdffile .. ' ' .. outfile)
                if not success then
                    io.stderr:write("Failed to convert PDF to SVG\n")
                    return nil
                end
            end

            local result = io.open(outfile, 'rb')
            if not result then
                io.stderr:write("Failed to read output file\n")
                return nil
            end
            local content = result:read("*all")
            result:close()
            return content
        end)
    end)
end

local extension_for = {
    html = 'svg',
    html4 = 'svg',
    html5 = 'svg',
    latex = 'pdf',
    beamer = 'pdf'
}

function RawBlock(el)
    if el.format == 'tex' and el.text:match('\\begin{tblr}') then
        local filetype = extension_for[FORMAT] or 'svg'
        local content = tabularray2image(el.text, filetype)

        if content then
            -- Generate a unique filename
            local fbasename = pandoc.sha1(el.text) .. '.' .. filetype

            -- Insert the content into pandoc's media bag
            pandoc.mediabag.insert(fbasename, "image/" .. filetype, content)

            return pandoc.Para({ pandoc.Image({}, fbasename) })
        else
            io.stderr:write("Failed to create image\n")
            return el
        end
    else
        return el
    end
end
