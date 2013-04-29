#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestWeatherReport < MiniTest::Unit::TestCase
  include WeatherReport

  def test_initialize
    assert_raises ArgumentError do
      Weather.new
    end
    assert_instance_of Weather, Weather.new(130010)
    puts Weather.new(130010).report
  end
end
