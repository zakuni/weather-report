# -*- coding: utf-8 -*-
require 'date'
require 'json'
require 'open-uri'
require 'nokogiri'
require 'weather-report/weather'
require 'weather-report/day'
require 'weather-report/version'

module WeatherReport
  class WeatherReportError < StandardError; end

  # @return [Weather] get weather of the city
  def self.get(city_name)
    Weather.new(Weather.request_cityid(city_name))
  end

  # @return [Array] get city list
  def self.cities
    proxy = Weather.parse_proxy(ENV["http_proxy"])
    doc = Nokogiri::XML(open("http://weather.livedoor.com/forecast/rss/primary_area.xml", :proxy_http_basic_authentication => [proxy.server, proxy.user, proxy.pass]))
    doc.xpath("//city").map{|i|
      i["title"]
    }
  end
end
