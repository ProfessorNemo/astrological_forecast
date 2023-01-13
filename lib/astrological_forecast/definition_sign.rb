# frozen_string_literal: true

module AstrologicalForecast
  class DefinitionSign
    attr_reader :definition, :signs

    def initialize(date:)
      @date = date
      # Номер знака зодиака
      @definition = date.nil? ? definition_sign_console : definition_sign_hands

      @signs = sign
    end

    def sign
      # Прочитаем файл со знаками зодиака и запишем данные в ассоциативный хэш-массив
      file = File.read("#{__dir__}/data/signs.json", encoding: 'utf-8')
      JSON.parse(file)
    end

    # Определение знака зодиака по дате рождения через консоль
    def definition_sign_console
      # Запрос у пользователя даты его рождения
      puts 'Когда вы родились (укажите дату в формате ДД.ММ, например, 31.12)'
      user_date_string = $stdin.gets.chomp

      AstrologicalForecast::Facts.sign_identification(sign, user_date_string)
    end

    def definition_sign_hands
      raise IncorrectDate unless @date.match?(/\A(\d{2})\.(\d{2})\z/)

      AstrologicalForecast::Facts.sign_identification(sign, @date)
    end
  end
end
