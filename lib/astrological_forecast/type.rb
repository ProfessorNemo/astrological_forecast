# frozen_string_literal: true

module AstrologicalForecast
  class Type
    attr_reader :user_type, :user_period

    def initialize
      @user_type = type
      @user_period = period
    end

    # Выбор разновидности(типа) гороскопа для определенного знака зодиака
    def type
      puts "\nВыберите разновидность гороскопа? Введите число от 1 до #{AstrologicalForecast::Facts::TYPES.size}:\n\n"

      AstrologicalForecast::Facts.give_types

      user_type = $stdin.gets.to_i
      puts

      until user_type.between?(1, AstrologicalForecast::Facts::TYPES.size)
        print "Введите номер знака зодиака от 1 до #{AstrologicalForecast::Facts::TYPES.size}: "
        user_type = $stdin.gets.to_i
        puts
      end
      user_type
    end

    # Выбор периода прогнозирования для определенного знака зодиака
    def period
      puts "Выберите период прогнозирования? Введите число от 1 до #{AstrologicalForecast::Facts::PERIOD.size}:\n\n"

      AstrologicalForecast::Facts.give_period

      user_period = $stdin.gets.to_i
      puts

      until user_period.between?(1, AstrologicalForecast::Facts::PERIOD.size)
        print "Введите номер знака зодиака от 1 до #{AstrologicalForecast::Facts::PERIOD.size}: "
        user_period = $stdin.gets.to_i
        puts
      end
      user_period
    end
  end
end
