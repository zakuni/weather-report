# -*- coding: utf-8 -*-

module WeatherReport
  class Day
    attr_reader :date, :telop, :temperature_min, :temperature_max

    def initialize(forecasts, dateLabel)
      @forecast = forecast(forecasts, dateLabel)
    end

    def date
      year, month, day = @forecast["date"].split('-')
      @date ||= Date.new(year.to_i, month.to_i, day.to_i)
    end

    def telop
      @telop ||= @forecast["telop"]
    end

    def temperature_min
      min = @forecast["temperature"]["min"]
      @temperature ||= 
        min ? min["celsius"].to_i : nil
    end

    def temperature_max
      max = @forecast["temperature"]["max"]
      @temperature_max ||= 
        max ? max["celsius"].to_i : nil
    end

    private

    def forecast(forecasts, dateLabel)
      forecasts["forecasts"].each {|elem| return elem if elem["dateLabel"] == dateLabel}
    end
  end
end
