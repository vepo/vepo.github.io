require 'rest-client'
require 'json'

module Jekyll
    class DevPost < Liquid::Tag
        def initialize(tag_name, article_id, tokens)
            super
            @article = JSON.parse(::RestClient.get("https://dev.to/api/articles/#{article_id.strip}"))
        end

        def render(context)
            tags_html = ""
            for tag in @article["tags"]
                tags_html = "#{tags_html}<div class=\"dev-tag\"><a href=\"https://dev.to/t/#{tag}\">#{tag}</a></div>"
            end
            output = <<~EOS
            <div class="dev-article">
                <div class="dev-user-picture">
                    <img src="#{@article["user"]["profile_image_90"]}" />
                </div>
                <div class="dev-article-title">
                    <a href="#{@article["url"]}">
                        #{@article["title"]}
                    </a>
                    <div class="dev-tags">#{tags_html}</div>
                </div>
                <div class="dev-logo">
                    <img src="/assets/images/plugins/dev-logo.webp" />
                </div>
            </div>
            EOS
        end
    end
end

Liquid::Template.register_tag('dev_post', Jekyll::DevPost)
