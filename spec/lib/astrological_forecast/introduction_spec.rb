# frozen_string_literal: true

RSpec.describe AstrologicalForecast::Introduction do
  specify '#init' do
    parser_stub = class_double described_class

    params =
      { number: nil,
        name_ru: nil,
        name_en: 'pisces',
        type: 'general',
        time: 'today' }

    hash = {
      name: 'Рыбы',
      date: 'Февраль 20 - Март 20',
      head: 'Я верю! Ключевая особенность - мечтательность.'
    }

    allow(parser_stub).to receive(:init).with(params)
                                        .and_return(hash)

    expect(parser_stub.init(params)).to be_a(Hash)

    expect(parser_stub.init(params)[:name]).to eq('Рыбы')

    expect(parser_stub).to have_received(:init).with(params).twice
  end
end
