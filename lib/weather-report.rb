# -*- coding: utf-8 -*-
require 'json'
require 'open-uri'
require "weather-report/version"

module WeatherReport
  class Weather
    attr_reader :today, :tomorrow, :day_after_tomorrow

    def initialize(city)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city}")
    end

    def today
      @today ||= forecast("今日")
    end
    
    def tomorrow
      @tomorrow ||= forecast("明日")
    end

    def day_after_tomorrow
      @day_after_tomorrow ||= forecast("明後日")
    end

    private

    def forecast(dateLabel)
      forecasts.each {|elem| return elem if elem["dateLabel"] == dateLabel}
    end
    
    def forecasts
      @forecasts ||= read["forecasts"]
    end

    def read
      @response ||= JSON.parse(@uri.read)
    end
  end
end
