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
end
