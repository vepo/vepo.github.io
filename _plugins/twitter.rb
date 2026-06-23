module Jekyll
  class TwitterTag < Liquid::Tag
    def initialize(tag_name, tweet_url, tokens)
      super
      @tweet_url = tweet_url.strip
    end

    def render(context)
      Jekyll::Embeds.twitter(@tweet_url)
    end
  end
end

Liquid::Template.register_tag('twitter', Jekyll::TwitterTag)
