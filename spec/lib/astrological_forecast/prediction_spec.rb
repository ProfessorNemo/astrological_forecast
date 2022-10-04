# frozen_string_literal: true

BASE_URL = 'https://orakul.com/'

RSpec.describe AstrologicalForecast::Prediction do
  context 'when is the general forecast for pisces for today' do
    describe '#initialize' do
      vars =
        { number: nil,
          name_ru: nil,
          name_en: 'pisces',
          type: 'general',
          time: 'today' }

      url = "#{BASE_URL}horoscope/astrologic/#{vars[:type]}/#{vars[:name_en]}/#{vars[:time]}.html"

      params = described_class.new(vars)

      it 'setting variable source when date is today' do
        expect(params).to be_a described_class
        expect(params.instance_variable_get(:@type)).to eq(vars[:type])
        expect(params.instance_variable_get(:@name)).to eq(vars[:name_en])
        expect(params.instance_variable_get(:@time)).to eq(vars[:time])
        expect(params.instance_variable_get(:@url)).to eq(url)
      end

      it 'attr_accessor when date is today' do
        expect(params.type).to eq(vars[:type])
        expect(params.name).to eq(vars[:name_en])
        expect(params.time).to eq(vars[:time])
      end

      it 'checking if a link matches a regular expression when date is today' do
        url =~ %r{\https://}
      end

      it '#fetch_forecast! - method that produces a prediction' do
        hash = {
          head: 'Общий гороскоп на сегодня, 4 октября, 2022',
          forecast: 'Сегодня Вы заработаете кучу денег!'
        }

        allow(params).to receive(:fetch_forecast!).and_return(hash)

        current = params.fetch_forecast!

        expect(current).to be_a(Hash)
        current[:head] =~ /Общий гороскоп на сегодня/
        current[:forecast] =~ /Сегодня Вы заработаете/
        expect(params).to have_received(:fetch_forecast!).once
      end
    end
  end
end
