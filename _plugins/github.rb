module Jekyll
  class GithubTag < Liquid::Tag
    def initialize(tag_name, repo, tokens)
      super
      @repo = repo.strip
    end

    def render(context)
      Jekyll::Embeds.github(@repo)
    end
  end
end

Liquid::Template.register_tag('github', Jekyll::GithubTag)
