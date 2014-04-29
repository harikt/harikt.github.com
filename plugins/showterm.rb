module Jekyll
  class Showterm < Liquid::Tag

    def initialize(name, id, tokens)
      super
      @id = id
    end

    def render(context)
      %(<div class="embed-video-container"><iframe src="http://showterm.io/#{@id}"></iframe></div>)
    end
  end
end

Liquid::Template.register_tag('showterm', Jekyll::Showterm)
