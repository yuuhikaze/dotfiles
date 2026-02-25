local system = require 'pandoc.system'

local standalone_template = [[
\documentclass{standalone}
\usepackage{xcolor}
\usepackage{tikz, pgfplots, tabularray}
\begin{document}
\nopagecolor
%s
\end{document}
]]

local function tabularray2image(src, filetype, outfile)
  return system.with_temporary_directory('tabularray2image', function (tmpdir)
    return system.with_working_directory(tmpdir, function()
      local f = io.open('temp.tex', 'w')
      if not f then
        io.stderr:write("Failed to create temp.tex\n")
        return false
      end
      f:write(standalone_template:format(src))
      f:close()

      local success, _, _ = os.execute('pdflatex -interaction=nonstopmode temp.tex')
      if not success then
        io.stderr:write("Failed to compile LaTeX\n")
        return false
      end

      if filetype == 'pdf' then
        os.rename('temp.pdf', outfile)
      else
        success, _, _ = os.execute('pdf2svg temp.pdf ' .. outfile)
        if not success then
          io.stderr:write("Failed to convert PDF to SVG\n")
          return false
        end
      end
      return true
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

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function RawBlock(el)
  if el.format == 'tex' and el.text:match('\\begin{tblr}') then
    local filetype = extension_for[FORMAT] or 'svg'
    local fbasename = pandoc.sha1(el.text) .. '.' .. filetype
    local fname = system.get_working_directory() .. '/' .. fbasename

    if not file_exists(fname) then
      local success = tabularray2image(el.text, filetype, fname)
      if not success then
        return el  -- Return original element if conversion fails
      end
    end

    -- Add a small delay to ensure file is fully written
    os.execute("sleep 0.1")

    if file_exists(fname) then
      return pandoc.Para({pandoc.Image({}, fbasename, nil, { width = '100%' })})
    else
      io.stderr:write("Failed to create image file: " .. fname .. "\n")
      return el
    end
  else
    return el
  end
end
