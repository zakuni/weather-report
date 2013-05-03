#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'test_helper'

class TestDay < MiniTest::Unit::TestCase
  include WeatherReport

  def setup
    @day = Day.new
  end

  def test_initialize
    assert_instance_of Day, Day.new
  end

  def test_date
    assert_respond_to @day, :date
  end

  def test_telop
    assert_respond_to @day, :telop
  end

  def test_temperature_min
    assert_respond_to @day, :temperature_min
  end

  def test_temperature_max
    assert_respond_to @day, :temperature_max
  end
end
