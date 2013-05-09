# Weather Report

A Ruby library and CLI to get Japanese Weather via Livedoor Weather Web Service(http://weather.livedoor.com/weather_hacks/webservice).

[![Build Status](https://travis-ci.org/zakuni/weather-report.png)](https://travis-ci.org/zakuni/weather-report)

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

# for easy use
tokyo = WeatherReport.get("東京")
tokyo.today.telop  # => "晴れ"

# or you can write like this
id = WeatherReport::Weather.request_cityid("東京")
weather = WeatherReport::Weather.new(id)
weather.tomorrow.date  # => <Date: 2013-05-04 ((2456417j,0s,0n),+0s,2299161j)>
weather.tomorrow.telop  # => "雨"
weather.tomorrow.temperature_min  # => 12
```
for more info, see http://rubydoc.info/gems/weather-report

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
