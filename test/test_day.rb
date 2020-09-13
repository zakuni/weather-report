#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require File.expand_path 'test_helper', File.dirname(__FILE__)

class TestDay < MiniTest::Unit::TestCase
  include WeatherReport

  def setup
    city_id = Weather.request_cityid("東京")
    uri = URI.parse("https://weather.tsukumijima.net/api/forecast?city=#{city_id}")
    @forecasts = JSON.parse(uri.read)
    @day = Day.new(@forecasts, "明日")
  end

  def test_initialize
    assert_instance_of Day, Day.new(@forecasts, "明日")
    assert_raises(ArgumentError) do
      Day.new(@forecasts, "昨日")
    end
  end

  def test_rain?
    assert_respond_to @day, :rain?
    @day.stub(:telop, '晴れ') do
      assert_equal @day.rain?, false
    end
    @day.stub(:telop, '雨') do
      assert_equal @day.rain?, true
    end
    @day.stub(:telop, '晴れ時々雨') do
      assert_equal @day.rain?, true
    end
  end

  def test_snow?
    assert_respond_to @day, :snow?
    @day.stub(:telop, '晴れ') do
      assert_equal @day.snow?, false
    end
    @day.stub(:telop, '雪') do
      assert_equal @day.snow?, true
    end
    @day.stub(:telop, '雪のち晴れ') do
      assert_equal @day.snow?, true
    end
  end

  def test_umbrella?
    assert_respond_to @day, :umbrella?
    @day.stub(:telop, '晴れ') do
      assert_equal @day.umbrella?, false
    end
    @day.stub(:telop, '雨') do
      assert_equal @day.umbrella?, true
    end
    @day.stub(:telop, '晴れのち雨') do
      assert_equal @day.umbrella?, true
    end
    @day.stub(:telop, '曇りのち晴れ') do
      assert_equal @day.umbrella?, false
    end
  end

  def test_date
    assert_respond_to @day, :date
    assert_instance_of Date, @day.date
  end

  def test_telop
    assert_respond_to @day, :telop
    assert_instance_of String, @day.telop
  end

  def test_temperature_min
    assert_respond_to @day, :temperature_min
    assert [Fixnum, NilClass].include? @day.temperature_min.class
  end

  def test_temperature_max
    assert_respond_to @day, :temperature_max
    assert [Fixnum, NilClass].include? @day.temperature_max.class
  end

  def test_to_h
    assert_respond_to @day, :to_h
  end

  def test_forecast
    forecasts = {"forecasts" => [{"dateLabel" => "明日"}]}
    refute_nil @day.send(:forecast, forecasts, "明日")
    assert_raises NoForecastError do
      @day.send(:forecast, forecasts, "明後日")
    end
  end
end
