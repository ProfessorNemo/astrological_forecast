# frozen_string_literal: true

module AstrologicalForecast
  class Type
    TYPES = AstrologicalForecast::Facts::TYPES
    PERIODS = AstrologicalForecast::Facts::PERIOD

    attr_reader :user_type, :user_period

    def initialize(type:, period:)
      @type = correct(type)

      @period = correct(period)

      @user_type = @type.nil? ? type_console : manual_check(@type, TYPES, IncorrectType)

      @user_period = @period.nil? ? period_console : manual_check(@period, PERIODS, IncorrectPeriod)
    end

    def correct(feature)
      return nil if feature.nil?

      feature = feature.is_a?(String) ? feature : feature.to_s

      feature.strip.downcase.capitalize
    end

    # Выбор разновидности(типа) гороскопа для определенного знака зодиака через консоль
    def type_console
      puts "\nВыберите разновидность гороскопа? Введите число от 1 до #{TYPES.size}:\n\n"

      AstrologicalForecast::Facts.give_types

      user_type = $stdin.gets.to_i
      puts

      until user_type.between?(1, TYPES.size)
        print "Введите номер от 1 до #{TYPES.size}: "
        user_type = $stdin.gets.to_i
        puts
      end

      user_type
    end

    # Выбор периода прогнозирования для определенного знака зодиака через консоль
    def period_console
      puts "Выберите период прогнозирования? Введите число от 1 до #{PERIODS.size}:\n\n"

      AstrologicalForecast::Facts.give_period

      user_period = $stdin.gets.to_i
      puts

      until user_period.between?(1, PERIODS.size)
        print "Введите число от 1 до #{PERIODS.size}: "
        user_period = $stdin.gets.to_i
        puts
      end

      user_period
    end

    # Проверка на корректность заданного типа прогноза и периода прогнозирования
    def manual_check(opt, const, error)
      types = const.each_with_index.each_with_object({}) do |(var, i), result|
        result[var[0]] = i + 1
      end

      raise error if types[opt].nil?

      types[opt]
    end
  end
end
