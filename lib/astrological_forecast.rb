# frozen_string_literal: true

# Программа "Зодиакальный гороскоп" (на сегодня, на завтра, на неделю, на месяц, на год)

require_relative 'main'

BASE_URL = 'https://orakul.com/'

module AstrologicalForecast
  def self.predict
    determinant = AstrologicalForecast::DefinitionSign.new

    characteristic = AstrologicalForecast::Type.new

    params = {
      definition: determinant.definition,
      signs: determinant.signs,
      user_type: characteristic.user_type,
      user_period: characteristic.user_period
    }

    forecast = AstrologicalForecast::Forecast.new(params)

    forecast.data_forecast
  end
end