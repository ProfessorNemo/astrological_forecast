# frozen_string_literal: true

module AstrologicalForecast
  module Facts
    TYPES = {
      'Общий' => 'general',
      'Любовный' => 'love',
      'Семейный' => 'family',
      'Карьерный' => 'career',
      'Здоровье' => 'health',
      'Тинейджер' => 'tinager',
      'Флирт' => 'flirt',
      'Друзья' => 'amigos'
    }.freeze

    PERIOD = {
      'На сегодня' => 'today',
      'На завтра' => 'tomorrow',
      'На неделю' => 'week',
      'На месяц' => 'month',
      'На год' => 'year'
    }.freeze

    class << self
      def give_types
        TYPES.keys.each(&:to_sym).each_with_index do |type, index|
          puts "#{index + 1}. #{type}"
        end
        puts
        print '> '
      end

      def give_period
        PERIOD.keys.each(&:to_sym).each_with_index do |period, index|
          puts "#{index + 1}. #{period}"
        end
        puts
        print '> '
      end

      def sign_identification(signs, user_date_string)
        user_date = Date.parse("#{user_date_string}.2000")

        user_sign = nil

        # Для ассоциативных массивов, как и для обычных, тоже есть метод each, он кладет
        # в переменные блока по очереди каждую пару ключ-значение.
        signs.each do |_, sign|
          dates = sign['dates'].split('..').map do |date_string|
            Date.parse("#{date_string}.2000")
          end

          user_sign = sign if dates.first <= user_date && user_date <= dates.last
        end
        user_sign
      end
    end
  end
end
