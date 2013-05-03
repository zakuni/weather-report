#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestWeather < MiniTest::Unit::TestCase
  include WeatherReport

  def setup
    @id = Weather.request_cityid("東京")
    @weather = Weather.new(@id)
  end

  def test_initialize
    assert_raises ArgumentError do
      Weather.new
    end
    assert_instance_of Weather, Weather.new(@id)
  end

  def test_today
    assert_respond_to @weather, :today

    today = @weather.today
    assert_includes(today, "date")
    assert_includes(today, "telop")
    assert_includes(today, "temperature")
  end

  def test_tomorrow
    assert_respond_to @weather, :tomorrow

    tomorrow = @weather.tomorrow
    assert_includes(tomorrow, "date")
    assert_includes(tomorrow, "telop")
    assert_includes(tomorrow, "temperature")
  end

  def test_day_after_tomorrow
    assert_respond_to @weather, :day_after_tomorrow

    day_after_tomorrow = @weather.day_after_tomorrow
    assert_includes(day_after_tomorrow, "date")
    assert_includes(day_after_tomorrow, "telop")
    assert_includes(day_after_tomorrow, "temperature")
  end

  def test_request_cityid
    assert_respond_to Weather, :request_cityid
    assert_equal "130010", Weather.request_cityid("東京")
    assert_equal "140010", Weather.request_cityid("横浜")
    assert_raises(WeatherReportError) do
      Weather.request_cityid(nil)
    end
  end
end
