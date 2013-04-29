#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestWeatherReport < MiniTest::Unit::TestCase
  include WeatherReport

  def test_initialize
    assert_instance_of Weather, Weather.new
  end
end
