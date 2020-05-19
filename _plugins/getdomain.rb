module Jekyll
    module GetDomainFilter 
        def getdomain(input)
            url = input.start_with?('http') ? input : "http://#{input}"
            uri = URI.parse(url)
            host = uri.host.downcase
            host.start_with?('www.') ? host[4..-1] : host
        end
    end
end

Liquid::Template.register_filter(Jekyll::GetDomainFilter)