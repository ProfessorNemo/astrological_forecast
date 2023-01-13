# frozen_string_literal: true

RSpec.describe AstrologicalForecast::Forecast do
  let(:forecast_class) { Struct.new(:definition, :signs, :user_type, :user_period, :console) }

  let(:signs) { JSON.parse(File.read('./spec/support/signs.json')) }

  let(:console) { true }

  let(:vars) do
    {
      'date' => '13.03',
      'общий' => '1',
      'на сегодня' => '1'
    }
  end

  let(:definition) { AstrologicalForecast::Facts.sign_identification(signs, vars['date']) }

  let(:forecast) { described_class.new(forecast_class.new(definition, signs, vars['общий'], vars['на сегодня'], console)) }

  specify '#data_forecast' do
    hash = {
      name: 'Рыбы',
      date: 'Февраль 20 - Март 20',
      head: 'Я верю! Ключевая особенность - мечтательность.',
      title: 'Общий гороскоп на сегодня, 3 октября, 2022',
      text: 'Сегодня Вы заработаете кучу денег!'
    }

    allow(forecast).to receive(:data_forecast).and_return(hash)

    current = forecast.data_forecast

    expect(current).to be_a(Hash)

    expect(current[:name]).to eq('Рыбы')

    expect(current[:text]) =~ /Сегодня Вы заработаете/

    expect(forecast).to have_received(:data_forecast).once
  end
end
