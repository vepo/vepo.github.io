module Jekyll
  class DevPost < Liquid::Tag
    def initialize(tag_name, article_id, tokens)
      super
      @article_id = article_id.strip
    end

    def render(context)
      Jekyll::Embeds.dev_post(@article_id)
    end
  end
end

Liquid::Template.register_tag('dev_post', Jekyll::DevPost)
