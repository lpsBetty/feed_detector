# -*- encoding: utf-8 -*-
require File.expand_path('../lib/feed_detector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bettina Steger"]
  gem.email         = ["bettina_steger@gmx.at"]
  gem.description   = %q{A ruby gem based on code from Dominiek's post (http://synaptify.com/?p=93) on detecting feeds. }
  gem.summary       = %q{A ruby gem based on code from Dominiek's post (http://synaptify.com/?p=93) on detecting feeds. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "feed_detector"
  gem.require_paths = ["lib"]
  gem.version       = FeedDetector::VERSION
end
