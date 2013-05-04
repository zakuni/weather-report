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
end
