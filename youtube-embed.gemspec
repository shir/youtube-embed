# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'youtube_embed/version'

Gem::Specification.new do |spec|
  spec.name          = "youtube-embed"
  spec.version       = YoutubeEmbed::VERSION
  spec.authors       = ["Ildar Shaynurov"]
  spec.email         = ["shaynurov@gmail.com"]
  spec.summary       = %q{Parse youtube video url and generate iframe html}
  spec.homepage      = "https://github.com/shir/youtube-embed"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.0'
end
