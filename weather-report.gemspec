require_relative 'lib/weather-report/version'

Gem::Specification.new do |spec|
  spec.name          = "weather-report"
  spec.version       = WeatherReport::VERSION
  spec.authors       = ["zakuni"]
  spec.email         = ["kunio038@gmail.com"]

  spec.description   = %q{A Ruby library and CLI to get Japanese Weather via 天気予報 API(https://weather.tsukumijima.net/) which is compatible with Livedoor Weather Web Service.}
  spec.summary       = %q{A Ruby client of 天気予報 API(https://weather.tsukumijima.net/).}
  spec.homepage      = "https://github.com/zakuni/weather-report"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "growl"
end
