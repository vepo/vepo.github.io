require 'rest-client'
require 'json'

module Jekyll
    class TwitterTag < Liquid::Tag
        def initialize(tag_name, tweet_url, tokens)
            super
            @tweet = JSON.parse(::RestClient.get("https://publish.twitter.com/oembed?theme=dark&align=center&url=#{ERB::Util.url_encode(tweet_url)}"))
        end

        def render(context)
            @tweet['html']
        end
    end
end

Liquid::Template.register_tag('twitter', Jekyll::TwitterTag)
