# frozen_string_literal: true

require_relative 'lib/astrological_forecast/version'

Gem::Specification.new do |spec|
  spec.name = 'astrological_forecast'
  spec.version = AstrologicalForecast::VERSION
  spec.authors = ['Gleb V. Zhegilin']
  spec.email = ['gleboceanborn@gmail.com']
  spec.summary = 'Zodiac horoscope parser from https://orakul.com.'
  spec.description = "Forecast for today, next day, week, month or year on request.
                     It is also possible to choose the type of horoscope."
  spec.homepage = 'https://github.com/ProfessorNemo/astrological_forecast'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.2'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.add_dependency 'nokogiri', '~> 1.13'
  spec.add_dependency 'open-uri'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
