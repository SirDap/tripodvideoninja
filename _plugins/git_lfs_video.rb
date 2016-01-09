# _plugins/git_lfs_video.rb
# special thanks to: https://talk.jekyllrb.com/t/how-to-create-simple-custom-note-tag/517
module Jekyll
  class GitLfsVideo < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      # strip leading and trailing spaces (throws off URL)
      @text = text.strip
      @gitrepo = "https://github.com/SirDap/tripodvideoninja"
      # the local storage folder
      @vidfolder="_assets/downloads"
    end

    def render(context)
      "#{@gitrepo}/blob/master/#{@vidfolder}/#{@text}?raw=true"
    end
  end
end

Liquid::Template.register_tag('lfs_video', Jekyll::GitLfsVideo)