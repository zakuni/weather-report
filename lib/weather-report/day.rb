# -*- coding: utf-8 -*-

module WeatherReport
  class Day
    attr_reader :date, :telop, :temperature_min, :temperature_max

    def initialize(forecasts, dateLabel)
      raise ArgumentError, "dateLabel must be 今日, 明日 or 明後日" unless dateLabel =~ /(今日|明日|明後日)/

      @forecast = forecast(forecasts, dateLabel)
      @telop = @forecast['telop']
      year, month, day = @forecast['date'].split('-')
      @date = Date.new(year.to_i, month.to_i, day.to_i)
      min = @forecast["temperature"]["min"]
      @temperature_min = min ? min["celsius"].to_i : nil
      max = @forecast["temperature"]["max"]
      @temperature_max = max ? max["celsius"].to_i : nil
    end

    # @return [Boolean] return true if it rains.
    def rain?
      telop =~ /[雨]/ ? true : false
    end

    # @return [Boolean] return true if it snows.
    def snow?
      telop =~ /[雪]/ ? true : false
    end

    # @return [Boolean] return true if it will be rainy or snowy or sleety or hailstorm
    def umbrella?
      telop =~ /[雨雪霙雹]/ ? true : false
    end

    # @return [Hash] return with hash format.
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
      raise NoForecastError
    end
  end
end
