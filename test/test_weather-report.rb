#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestWeatherReport < MiniTest::Unit::TestCase
  include WeatherReport

  def setup
    # 130010は東京
    @weather = Weather.new(130010)
  end

  def test_initialize
    assert_raises ArgumentError do
      Weather.new
    end
    assert_instance_of Weather, Weather.new(130010)
  end

  def test_today
    assert_respond_to @weather, :today
  end

  def test_tomorrow
    assert_respond_to @weather, :tomorrow
  end

  def test_day_after_tomorrow
    assert_respond_to @weather, :day_after_tomorrow
  end
end
