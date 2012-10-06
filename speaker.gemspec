# -*- encoding: utf-8 -*-
require File.expand_path('../lib/speaker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David William"]
  gem.email         = ["david@webhall.com.br"]
  gem.description   = %q{Flexible text to speech using Google Translator}
  gem.summary       = %q{Enjoy the power and flexibility of Google Translator by transforming any text in audio.}
  gem.homepage      = "https://github.com/davidwilliam/speaker"

  gem.files         = Dir["{lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "speaker"
  gem.require_paths = ["lib"]
  gem.version       = Speaker::VERSION
  gem.add_dependency "mechanize"
end
