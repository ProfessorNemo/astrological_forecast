# frozen_string_literal: true

module AstrologicalForecast
  OPTIONS_TYPE = %w[Общий Любовный Семейный Карьерный Здоровье Тинейджер Флирт Друзья].freeze
  OPTIONS_PERIOD = ['На сегодня', 'На завтра', 'На неделю', 'На месяц', 'На год'].freeze

  class IncorrectType < StandardError
    def message
      "Некорректный тип прогноза (см. #{OPTIONS_TYPE})"
    end
  end

  class IncorrectDate < StandardError
    def message
      'Указан некорректный формат даты (ДД.ММ)'
    end
  end

  class IncorrectPeriod < StandardError
    def message
      "Некорректный период прогнозирования (см. #{OPTIONS_PERIOD})"
    end
  end
end
