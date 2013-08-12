# -*- coding: utf-8 -*-

module WeatherReport
  class Weather
    attr_reader :today, :tomorrow, :day_after_tomorrow

    def initialize(city_id)
      @uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city_id}")
    end

    # @return [String] the id of given city
    def self.request_cityid(city_name)
      raise ArgumentError, "City name must be String." unless city_name.kind_of?(String)
      proxy = Weather.parse_proxy(ENV["http_proxy"])
      doc = Nokogiri::XML(open("http://weather.livedoor.com/forecast/rss/primary_area.xml", :proxy_http_basic_authentication => [proxy.server, proxy.user, proxy.pass]))
      doc.search("//city[@title='#{city_name}']").attr("id").value
    rescue NoMethodError
      raise WeatherReportError, "It seems like city #{city_name} does not exist.\nPlease look at http://weather.livedoor.com/forecast/rss/primary_area.xml for city list."
    end

    def self.parse_proxy(proxy)
      # http://user:pass@host:port のように書かれていることを想定
      # パスワードに@とか入ってる場合があるので一番後ろの@でだけsplitする
      rserver, raccount = (proxy || '').sub(/http:\/\//, '').reverse.split("@", 2)
      server  = rserver.nil? ? "" : rserver.reverse
      host, port = server.split(":")
      account = raccount.nil? ? "" : raccount.reverse.split(":")
      user, pass = account
      
      proxy = OpenStruct.new({      
                               "server" => server.empty? ? nil : "http://#{server}",
                               "user"   => user.nil? ? "" : user,
                               "pass"   => pass.nil? ? "" : pass
                             })
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

    # @return [String] the URL of the requested livedoor weather
    def link
      @response ||= read
      @response["link"]
    end

    # @return [Hash] the weather with Hash format
    def to_h
      {
        "today" => today.to_h,
        "tomorrow" => tomorrow.to_h,
        "day_after_tomorrow" => day_after_tomorrow.to_h,
        "link" => link
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
