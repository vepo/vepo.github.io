require 'liquid'

module GetDomainFilter 
    def get_domain(input)
        url = input.start_with?('http') ? input : "http://#{input}"
        uri = URI.parse(url)
        host = uri.host.downcase
        return host.start_with?('www.') ? host[4..-1] : host
    end
end

Liquid::Template.register_filter(GetDomainFilter)