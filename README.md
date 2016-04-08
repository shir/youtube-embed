# YoutubeEmbed

This library allows you to parse a YouTube video url and generate html code for embedding video in your page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'youtube-embed'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install youtube-embed

## Usage

```ruby
require `youtube_embed`

video = YoutubeEmbed::Video.new('https://www.youtube.com/watch?v=XD_e7T5WCqw') # You may use short url too like 'https://youtu.be/XD_e7T5WCqw'
video.iframe
```
or shorter
```ruby
require `youtube_embed`

YoutubeEmbed::Video.iframe('https://www.youtube.com/watch?v=XD_e7T5WCqw')
```

### Options

You also may pass some options
```ruby
YoutubeEmbed::Video.new('https://www.youtube.com/watch?v=XD_e7T5WCqw', { show_similar: true })
```
Next options are available:

- `show_similar` - show similar video when video is finished. Default `false`.
- `show_title`   - show video title. Default `true`.
- `show_controls` - show video controls. Default `true`.
- `allow_fullscreen` - allow user to switch video in fullscreen model. Default `true`.
- `width` - wdith of iframe. Default `640`.
- `height` - height of iframe. Default `360`.

## Contributing

1. Fork it ( https://github.com/shir/youtube-embed/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
