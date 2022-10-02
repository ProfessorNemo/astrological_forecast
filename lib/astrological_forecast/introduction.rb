# frozen_string_literal: true

module AstrologicalForecast
  module Introduction
    def self.init(vars)
      html = URI.parse(::BASE_URL).read
      document = Nokogiri::HTML(html)

      zodiac = document.css('div.main ul > li')[vars[:number].to_i - 1]
      {
        name: zodiac.at('a .name').text,
        date: zodiac.at('a .per').text,
        head: zodiac.css(".ico-#{vars[:name_en]}")
                    .text.strip.gsub(/\s{2,}/, ', ')
                    .split(', ')[2]
      }
    end
  end
end
