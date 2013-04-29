require 'json'
require 'open-uri'
require "weather-report/version"

module WeatherReport
  class Weather
    def initialize(city)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city}")
    end

    def report
      JSON.parse(@uri.read)
    end
  end
end
