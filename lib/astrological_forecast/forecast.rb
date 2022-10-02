# frozen_string_literal: true

module AstrologicalForecast
  class Forecast
    def initialize(params)
      @definition = params[:definition]
      @signs = params[:signs]
      @user_type = params[:user_type]
      @user_period = params[:user_period]
    end

    # получение прогноза
    def data_forecast
      # очистить экран
      puts "\e[H\e[2J"

      vars =
        { number: @definition['number'],
          name_ru: @definition['sign_ru'],
          name_en: @signs.keys[@definition['number'].to_i - 1],
          type: AstrologicalForecast::Facts::TYPES[AstrologicalForecast::Facts::TYPES.keys.each(&:to_sym)[@user_type - 1]],
          time: AstrologicalForecast::Facts::PERIOD[AstrologicalForecast::Facts::PERIOD.keys.each(&:to_sym)[@user_period - 1]] }

      begin
        intro = AstrologicalForecast::Introduction.init(vars)
        prediction = AstrologicalForecast::Prediction.new(vars).fetch_forecast!
      rescue SocketError => e
        puts "Ошибка соединения с сервером: #{e.message}"
        abort e.message
      end

      forecast_results(intro, prediction)
    end

    def forecast_results(intro, prediction)
      puts <<~HOROSCOPE
        #{intro[:name]}:\n#{intro[:date]},\n#{intro[:head]}
        #{@definition["text"]}\n
        #{prediction[:head]}:\n\n#{prediction[:forecast]}
      HOROSCOPE
    end
  end
end
