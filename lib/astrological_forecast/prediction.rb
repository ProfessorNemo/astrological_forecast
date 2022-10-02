# frozen_string_literal: true

module AstrologicalForecast
  class Prediction
    attr_accessor :type, :name, :time

    def initialize(vars)
      @type = vars[:type]
      @name = vars[:name_en]
      @time = vars[:time]
      @url = "#{::BASE_URL}horoscope/astrologic/#{@type}/#{@name}/#{@time}.html"
    end

    def fetch_page!
      @fetch_page ||= URI.parse(@url).open
    end

    def fetch_more!(url_more = nil)
      url_more = @url.gsub(type, 'more') if (type == 'general') & (time == 'today')
      url_more = @url.gsub(type, 'more') if (type == 'general') & (time == 'tomorrow')
      return nil if url_more.nil?

      @fetch_more ||= URI.parse(url_more).read
    end

    def fetch_forecast!
      @fetch_forecast ||= begin
        document = Nokogiri::HTML(fetch_page!)
        record = document.css('div.contentOnly p')[0].children.text.strip
        record = "#{record.delete(".")} или не существует!" if record.match?(/\Извините/)

        predict =
          {
            head: document.css('div.contentOnly #type2 h2')
                          .children.text
                          .strip.gsub(/\s{2,}/, ' '),
            forecast: record
          }
      end

      if fetch_more!.nil?
        predict
      else
        document = Nokogiri::HTML(fetch_more!)
        predict = predict.merge(details: document.css('div.contentOnly p')[0].children.text.strip)
        {
          head: predict[:head],
          forecast: "#{predict[:forecast]}\n#{predict[:details]}"
        }
      end
    end
  end
end
