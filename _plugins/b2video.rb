# A plugin for embedding self-hosted videos on Backblaze B2
# Special thanks to:
# https://stackoverflow.com/questions/52432066/calling-one-jekyll-plugin-from-another
# 
module Jekyll
  class B2Video < Liquid::Tag
    @@width = 640
    @@height = 360

    def initialize(name, input, tokens)
      super
      @id = split_params(input)[0].strip
      @pic = split_params(input)[1].strip
      @b2repo = "https://f000.backblazeb2.com/file/TripodVideoNinja"
      
    end

    def render(context)
      
      @poster = Jekyll::Assets::Tag.send(:new, 'asset', @pic + " @path", Liquid::ParseContext.new).render(context)
      
      %(<div class="videoWrapper">
          <video controls width="#{@@width}" height="#{@@height}" 
            preload="metadata" poster="#{@poster}"
          >
              <source src="#{@b2repo}/#{@id}" type="video/mp4">Your browser does not support the video tag.
          </video>
      </div>)
    end
    
    def split_params(params)
      params.split("|")
    end
  end
end

Liquid::Template.register_tag('b2video', Jekyll::B2Video)