# frozen_string_literal: true

require 'simplecov'

# Запуск измерителя покрытия кода тестами с игнорированием некоторых директорий:
SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
end

# Если тесты работают на "Continuous Integration", то данные затем отрпавить на сервис "Codecov"
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require_relative '../lib/main'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end