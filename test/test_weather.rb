#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require File.expand_path 'test_helper', File.dirname(__FILE__)

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
    assert_instance_of Day, today
  end

  def test_tomorrow
    assert_respond_to @weather, :tomorrow

    tomorrow = @weather.tomorrow
    assert_instance_of Day, tomorrow
  end

  def test_day_after_tomorrow
    assert_respond_to @weather, :day_after_tomorrow

    day_after_tomorrow = @weather.day_after_tomorrow
    assert_instance_of Day, day_after_tomorrow
  end

  def test_link
    assert_respond_to @weather, :link
    assert_instance_of String, @weather.link
  end

  def test_request_cityid
    assert_respond_to Weather, :request_cityid
    assert_equal "130010", Weather.request_cityid("東京")
    assert_equal "140010", Weather.request_cityid("横浜")
    assert_raises(ArgumentError) do
      Weather.request_cityid(nil)
    end
  end

  def test_to_h
    assert_respond_to @weather, :to_h
  end
end
