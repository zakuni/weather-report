# -*- coding: utf-8 -*-
require 'json'
require 'open-uri'
require 'nokogiri'
require "weather-report/version"

module WeatherReport
  class WeatherReportError < StandardError; end

  class Weather
    attr_reader :today, :tomorrow, :day_after_tomorrow

    def initialize(city_id)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city_id}")
    end

    def self.request_cityid(city)
      doc = Nokogiri::XML(open("http://weather.livedoor.com/forecast/rss/primary_area.xml"))
      doc.search("//city[@title='#{city}']").attr("id").value
    rescue
      raise WeatherReportError
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
    rescue
      raise WeatherReportError
    end
  end
end
