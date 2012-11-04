# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'embed/version'

Gem::Specification.new do |gem|
  gem.name          = "embed"
  gem.version       = Embed::VERSION
  gem.authors       = ["Neil Carvalho"]
  gem.email         = ["me@neil.pro"]
  gem.description   = %q{An easy way to embed media to your Rails app}
  gem.summary       = %q{An easy way to embed media to your Rails app}
  gem.homepage      = "https://github.com/neilvilela/embed"

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'fakeweb'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
