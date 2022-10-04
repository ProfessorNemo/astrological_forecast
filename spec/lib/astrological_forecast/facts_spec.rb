# frozen_string_literal: true

RSpec.describe AstrologicalForecast::Facts do
  let(:signs) { JSON.parse(File.read('./spec/support/signs.json')) }

  let(:zodiac) { described_class.sign_identification(signs, '10.03') }

  describe '#sign_identification' do
    it 'has a number, sign_ru, dates and text key in the hash' do
      expect(zodiac).to be_a(Hash)

      expect(zodiac.keys).to eq %w[number sign_ru dates text]

      expect(zodiac['number']).to eq '12'

      expect(zodiac['sign_ru']).to eq 'Рыбы'

      expect(zodiac['dates']).to eq '20.02..20.03'

      signs['text'] =~ /Одна из самых занятных особенностей Рыб/
    end
  end
end
