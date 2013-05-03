# -*- coding: utf-8 -*-

module WeatherReport
  class Weather
    attr_reader :today, :tomorrow, :day_after_tomorrow

    def initialize(city_id)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city_id}")
    end

    def self.request_cityid(city)
      doc = Nokogiri::XML(open("http://weather.livedoor.com/forecast/rss/primary_area.xml"))
      doc.search("//city[@title='#{city}']").attr("id").value
    rescue
      raise WeatherReportError
    end

    def today
      @today ||= Day.new(forecasts, "今日")
    end
    
    def tomorrow
      @tomorrow ||= Day.new(forecasts, "明日")
    end

    def day_after_tomorrow
      @day_after_tomorrow ||= Day.new(forecasts, "明後日")
    end

    private

    def forecasts
      @forecasts ||= read
    end

    def read
      @response ||= JSON.parse(@uri.read)
    rescue e
      raise WeatherReportError
    end
  end
end
