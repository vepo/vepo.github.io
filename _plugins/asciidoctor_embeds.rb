require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  preprocessor do
    process do |_document, reader|
      new_lines = reader.source_lines.flat_map do |line|
        if (match = Jekyll::Embeds::TAG_PATTERN.match(line))
          html = Jekyll::Embeds.render(match[1], match[2])
          ['++++', html, '++++']
        else
          [line]
        end
      end
      Asciidoctor::Reader.new(new_lines, reader)
    end
  end
end
