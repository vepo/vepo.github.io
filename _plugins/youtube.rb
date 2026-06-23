module Jekyll
  class YoutubeTag < Liquid::Tag
    def initialize(tag_name, youtube_id, tokens)
      super
      @youtube_id = youtube_id.strip
    end

    def render(context)
      Jekyll::Embeds.youtube(@youtube_id)
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::YoutubeTag)
