# -*- coding: utf-8 -*-

module WeatherReport
  class Day
    attr_reader :date, :telop, :temperature_min, :temperature_max

    def initialize(forecasts, dateLabel)
      @forecast = forecast(forecasts, dateLabel)
    end

    # @return [Date] the date
    def date
      year, month, day = @forecast["date"].split('-')
      @date ||= Date.new(year.to_i, month.to_i, day.to_i)
    end

    # @return [String] the telop
    def telop
      @telop ||= @forecast["telop"]
    end

    # @return [Fixnum] the minimum temperature. 
    # Temperature of today could be nil.
    def temperature_min
      min = @forecast["temperature"]["min"]
      @temperature ||= 
        min ? min["celsius"].to_i : nil
    end

    # @return [Fixnum] the maximum temperature. 
    # Temperature of today could be nil.
    def temperature_max
      max = @forecast["temperature"]["max"]
      @temperature_max ||= 
        max ? max["celsius"].to_i : nil
    end

    def to_h
      {
        "date" => date.to_s,
        "telop" => telop,
        "temperature_min" => temperature_min,
        "temperature_max" => temperature_max
      }
    end

    private

    def forecast(forecasts, dateLabel)
      forecasts["forecasts"].each {|elem| return elem if elem["dateLabel"] == dateLabel}
    end
  end
end