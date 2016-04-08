module YoutubeEmbed
  class Video
    class << self
      def iframe(video_url, options = {})
        new(video_url, options).iframe
      end
    end

    def initialize(video_url, options = {})
      @video_url = video_url
      @options = {
        allow_fullscreen: true,
        show_title:       true,
        show_similar:     false,
        show_controls:    true,
        width:            640,
        height:           360
      }.merge(options.inject({}){ |o,(k,v)| o[k.to_sym] = v; o })
    end

    def video_id
      @video_id ||=
        if @video_url[/youtu\.be\/([^\?]*)/]
          $1
        else
          @video_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
          $5
        end
    end

    %w[allow_fullscreen show_title show_similar show_controls].each do |opt_name|
      define_method "#{opt_name}?" do
        @options[opt_name.to_sym]
      end
    end

    %w[width height].each do |opt_name|
      define_method "#{opt_name}" do
        @options[opt_name.to_sym]
      end
    end

    def embed_url
      params = {}.tap do |p|
        p['rel'] = 0 if !show_similar?
        p['showinfo'] = 0 if !show_title?
        p['controls'] = 0 if !show_controls?
      end

      "https://www.youtube.com/embed/#{video_id}#{params.size == 0 ? '' : '?' + params.map{ |k, v| "#{k}=#{v}" }.join('&amp;')}"
    end

    def iframe
      %(<iframe width="#{width}" height="#{height}" src="#{embed_url}" frameborder="0"#{' allowfullscreen' if allow_fullscreen?}></iframe>)
    end
  end
end
