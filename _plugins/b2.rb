# _plugins/b2.rb
# special thanks to: https://talk.jekyllrb.com/t/how-to-create-simple-custom-note-tag/517
module Jekyll
  class BackblazeB2Download < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      # strip leading and trailing spaces (throws off URL)
      @text = text.strip
      @b2repo = "https://f000.backblazeb2.com/file/TripodVideoNinja"
      # the local storage folder
      @vidfolder="_assets/downloads"
    end

    def render(context)
      "#{@b2repo}/#{@text}"
    end
  end
end

Liquid::Template.register_tag('b2', Jekyll::BackblazeB2Download)