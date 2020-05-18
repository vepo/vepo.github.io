module Jekyll
    class GetDomainTag < Liquid::Tag
  
      def initialize(tag_name, text, tokens)
        super
        url = "http://#{text}" unless text.start_with?('http')
        uri = URI.parse(url)
        host = uri.host.downcase
        host.start_with?('www.') ? host[4..-1] : host
        @text = host
      end
  
      def render(context)
        "#{@text}"
      end
    end
  end
  
  Liquid::Template.register_tag('get_domain', Jekyll::GetDomainTag)