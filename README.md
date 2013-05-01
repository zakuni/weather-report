# Weather Report

A Ruby library and CLI to get Japanese Weather via Livedoor Weather Web Service(http://weather.livedoor.com/weather_hacks/webservice).

## Installation

Add this line to your application's Gemfile:

    gem 'weather-report'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weather-report

## Usage

```ruby
require 'weather-report'

id = WeatherReport::Weather.request_cityid("東京")
weather = WeatherReport::Weather.new(id)
weather.today["telop"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
