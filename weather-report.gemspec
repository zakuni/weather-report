# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weather-report/version'

Gem::Specification.new do |spec|
  spec.name          = "weather-report"
  spec.version       = WeatherReport::VERSION
  spec.authors       = ["zakuni"]
  spec.email         = ["kunio038@gmail.com"]
  spec.description   = %q{A Ruby library and CLI to get Japanese Weather via Livedoor Weather Web Service(http://weather.livedoor.com/weather_hacks/webservice).}
  spec.summary       = %q{A Ruby client of Livedoor Weather Web Service.}
  spec.homepage      = "https://github.com/zakuni/weather-report"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "growl"
end
