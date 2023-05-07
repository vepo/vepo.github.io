module Jekyll
    class GistTag < Liquid::Tag
        def initialize(tag_name, gist_url, tokens)
            super
            @gist_url = gist_url.strip
        end

        def render(context)
            "<div data-gist=\"#{@gist_url}\"></div>"
        end
    end
end

Liquid::Template.register_tag('gist', Jekyll::GistTag)
