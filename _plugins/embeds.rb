require 'rest-client'
require 'json'

module Jekyll
  module Embeds
    TAG_PATTERN = /\{%\s*(youtube|gist|github|twitter|dev_post)\s+(.+?)\s*%\}/

    def self.render(tag, arg)
      arg = arg.strip
      case tag
      when 'youtube' then youtube(arg)
      when 'gist' then gist(arg)
      when 'github' then github(arg)
      when 'twitter' then twitter(arg)
      when 'dev_post' then dev_post(arg)
      end
    end

    def self.youtube(id)
      "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/#{id}\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
    end

    def self.gist(url)
      "<div data-gist=\"#{url}\"></div>"
    end

    def self.github(_repo)
      # API integration commented out in original plugin
      'bla'
    end

    def self.twitter(_tweet_url)
      # oEmbed integration commented out in original plugin
      nil
    end

    def self.dev_post(article_id)
      article = JSON.parse(::RestClient.get("https://dev.to/api/articles/#{article_id}"))
      tags_html = article['tags'].map do |tag|
        "<div class=\"dev-tag\"><a href=\"https://dev.to/t/#{tag}\">#{tag}</a></div>"
      end.join
      <<~HTML
        <div class="dev-article">
            <div class="dev-user-picture">
                <img src="#{article['user']['profile_image_90']}" />
            </div>
            <div class="dev-article-title">
                <a href="#{article['url']}">
                    #{article['title']}
                </a>
                <div class="dev-tags">#{tags_html}</div>
            </div>
            <div class="dev-logo">
                <img src="/assets/images/plugins/dev-logo.webp" />
            </div>
        </div>
      HTML
    end
  end
end
