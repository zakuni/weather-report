#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestDay < MiniTest::Unit::TestCase
  include WeatherReport

  def setup
    city_id = Weather.request_cityid("東京")
    uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city_id}")
    @forecasts = JSON.parse(uri.read)
    @day = Day.new(@forecasts, "明日")
  end

  def test_initialize
    assert_instance_of Day, Day.new(@forecasts, "明日")
  end

  def test_date
    assert_respond_to @day, :date
    assert_instance_of Date, @day.date
  end

  def test_telop
    assert_respond_to @day, :telop
  end

  def test_temperature_min
    assert_respond_to @day, :temperature_min
    assert_instance_of Fixnum, @day.temperature_min
  end

  def test_temperature_max
    assert_respond_to @day, :temperature_max
    assert_instance_of Fixnum, @day.temperature_max
  end
end
