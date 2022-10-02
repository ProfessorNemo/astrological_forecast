# frozen_string_literal: true

module AstrologicalForecast
  class DefinitionSign
    attr_reader :definition, :signs

    def initialize
      # Номер знака зодиака
      @definition = definition_sign
      @signs = sign
    end

    def sign
      # Прочитаем файл со знаками зодиака и запишем данные в ассоциативный хэш-массив
      file = File.read("#{__dir__}/data/signs.json", encoding: 'utf-8')
      JSON.parse(file)
    end

    # Определение знака зодиака по дате рождения
    def definition_sign
      # Запрос у пользователя даты его рождения
      puts 'Когда вы родились (укажите дату в формате ДД.ММ, например, 31.12)'
      user_date_string = $stdin.gets.chomp

      AstrologicalForecast::Facts.sign_identification(sign, user_date_string)
    end
  end
end
