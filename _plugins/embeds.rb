require 'rest-client'
require 'json'
require 'erb'

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
      <<~HTML
        <div class="img-block">
          <iframe width="560" height="315" src="https://www.youtube.com/embed/#{id}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
      HTML
    end

    def self.gist(url)
      "<div data-gist=\"#{url}\"></div>"
    end

    def self.github(repo)
      repo = repo.start_with?('https://github.com/') ? repo[19..-1] : repo
      headers = {
        accept: 'application/vnd.github+json',
        'x-gitHub-api-version': '2022-11-28'
      }
      if (github_token = ENV['MY_GITHUB_SECRET']) && !github_token.empty?
        headers[:authorization] = "Bearer #{github_token}"
      end
      repo_info = JSON.parse(::RestClient.get("https://api.github.com/repos/#{repo.strip}", headers))
      <<~HTML
        <div class="github-repo">
            <h2>
                <img class="logo" src="/assets/images/plugins/github-logo.png" alt="GitHub logo" loading="lazy" />
                <img class="user" src="#{repo_info['owner']['avatar_url']}" loading="lazy" />
                <span class="url">
                    <a href="https://github.com/#{repo_info['owner']['login']}">
                        #{repo_info['owner']['login']}
                    </a>
                    /
                    <a href="https://github.com/#{repo_info['owner']['login']}/#{repo_info['name']}">
                        #{repo_info['name']}
                    </a>
                </span>
            </h2>
        </div>
      HTML
    end

    def self.twitter(tweet_url)
      url = tweet_url.strip
      oembed_url = "https://publish.twitter.com/oembed?theme=dark&align=center&url=#{ERB::Util.url_encode(url)}"
      tweet = JSON.parse(::RestClient.get(oembed_url))
      tweet['html']
    rescue RestClient::Exception
      <<~HTML
        <blockquote class="twitter-tweet" data-theme="dark" data-align="center">
          <a href="#{url}"></a>
        </blockquote>
        <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
      HTML
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
