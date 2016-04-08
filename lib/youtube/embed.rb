require "youtube/embed/version"

module Youtube
  module Embed
    class << self
      def iframe(video_url, options = {})
        new(video_url, options).iframe
      end
    end

    def initialize(video_url, options = {})
      @video_url = video_url
      @options = {
        allow_fullscreen: true,
        show_title: true,
        show_similar: false,
      }.merge(options.symbolize_keys)
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

    %w[allow_fullscreen show_title show_similar].each do |opt_name|
      define_method "#{opt_name}?" do
        @options[opt_name.to_sym]
      end
    end

    def embed_url
      params = {}.tap do |p|
        p['rel'] = 0 if !show_similar?
        p['showinfo'] = 0 if !show_title?
      end

      "https://www.youtube.com/embed/#{video_id}?#{params.map{ |k, v| "#{k}=#{v}" }.join('&amp;')}"
    end

    def iframe
      %(<iframe width="640" height="360" src="#{embed_url}" frameborder="0" #{'allowfullscreen' if allow_fullscreen?}></iframe>).html_safe
    end
  end
end
