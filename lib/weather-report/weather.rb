# -*- coding: utf-8 -*-

module WeatherReport
  class Weather
    attr_reader :today, :tomorrow, :day_after_tomorrow

    def initialize(city_id)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city_id}")
    end

    # @return [String] the id of given city
    def self.request_cityid(city)
      doc = Nokogiri::XML(open("http://weather.livedoor.com/forecast/rss/primary_area.xml"))
      doc.search("//city[@title='#{city}']").attr("id").value
    rescue => e
      raise WeatherReportError
    end

    # @return [Day] the today
    def today
      @today ||= Day.new(forecasts, "今日")
    end

    # @return [Day] the tomorrow
    def tomorrow
      @tomorrow ||= Day.new(forecasts, "明日")
    end

    # @return [Day] the day after tomorrow
    def day_after_tomorrow
      @day_after_tomorrow ||= Day.new(forecasts, "明後日")
    end

    def to_h
      {
        "today" => today.to_h,
        "tomorrow" => tomorrow.to_h,
        "day_after_tomorrow" => day_after_tomorrow.to_h
      }
    end

    private

    def forecasts
      @forecasts ||= read
    end

    def read
      @response ||= JSON.parse(@uri.read)
    rescue => e
      raise WeatherReportError
    end
  end
end
