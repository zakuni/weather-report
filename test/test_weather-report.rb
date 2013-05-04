#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestWeatherReport < MiniTest::Unit::TestCase
  
  def test_get
    assert_respond_to WeatherReport, :get
    assert_instance_of WeatherReport::Weather, WeatherReport.get("横浜")
  end
end
