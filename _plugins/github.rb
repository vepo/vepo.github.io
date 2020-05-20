require 'rest-client'
require 'json'

module Jekyll
    class GithubTag < Liquid::Tag
        def initialize(tag_name, repo, tokens)
            super
            @repo = repo
        end

        def render(context)
            "<iframe src=\"https://github.com/#{@repo}\" frameBorder=\"0\" width=\"100%\" height=\"512px\"></iframe>"
        end
    end
end

Liquid::Template.register_tag('github', Jekyll::GithubTag)
