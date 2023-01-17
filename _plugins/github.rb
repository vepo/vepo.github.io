require 'rest-client'
require 'json'

module Jekyll
    class GithubTag < Liquid::Tag
        def initialize(tag_name, repo, tokens)

            ##  curl \
            ##    -H "Accept: application/vnd.github+json" \
            ##    -H "Authorization: Bearer <YOUR-TOKEN>"\
            ##    -H "X-GitHub-Api-Version: 2022-11-28" \
            ##    https://api.github.com/repos/OWNER/REPO
            super
            repo = repo.start_with?('https://github.com/') ? repo[19..-1] : repo
            github_token = ENV["GITHUB_TOKEN"]
            @repo_info = JSON.parse(::RestClient.get("https://api.github.com/repos/#{repo.strip}", {:authorization => "Bearer #{auth_key}", :accept => "application/vnd.github+json", :'x-gitHub-api-version' => '2022-11-28'}))
            puts @repo_info
        end

        def render(context)
            output = <<~EOS
            <div class="github-repo">
                <h2>
                    <img class="logo" src="/assets/images/plugins/github-logo.png" alt="GitHub logo" loading="lazy" />
                    <img class="user" src="#{@repo_info["owner"]["avatar_url"]}" loading="lazy" />
                    <span class="url">
                        <a href="https://github.com/#{@repo_info["owner"]["login"]}">
                            #{@repo_info["owner"]["login"]}
                        </a> 
                        /
                        <a href="https://github.com/#{@repo_info["owner"]["login"]}/#{@repo_info["name"]}">
                            #{@repo_info["name"]}
                        </a>
                    </span>
                </h2>
            </div>
            EOS
        end
    end
end

Liquid::Template.register_tag('github', Jekyll::GithubTag)
