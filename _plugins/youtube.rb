require 'rest-client'
require 'json'

module Jekyll
    class YoutubeTag < Liquid::Tag
        def initialize(tag_name, youtube_id, tokens)
            super
            @youtube_id = youtube_id.strip
        end

        def render(context)
            "<div>a</div><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/#{@youtube_id}\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
        end
    end
end

Liquid::Template.register_tag('youtube', Jekyll::YoutubeTag)
