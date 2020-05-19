require 'liquid'

module Jekyll
    module GetDomainFilter 
        def get_domain(input)
            host = URI.parse(input.start_with?('http') ? input : "http://#{input}").host.downcase
            host.start_with?('www.') ? host[4..-1] : host
        end
    end
end

Liquid::Template.register_filter(Jekyll::GetDomainFilter)