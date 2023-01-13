# frozen_string_literal: true

RSpec.describe AstrologicalForecast::DefinitionSign do
  let(:date) { '10.03' }

  let(:sign) { JSON.parse(File.read('./spec/support/signs.json')) }

  let(:body) do
    { 'dates' => '20.02..20.03',
      'number' => '12',
      'sign_ru' => 'Рыбы',
      'text' => 'Одна из самых занятных особенностей Рыб ' \
                '- умение посмотреть на себя со стороны и оценить ' \
                'как сильные, так и слабые стороны. Хорошо зная, что ' \
                'им по силам, а что нет, представители этого знака относятся ' \
                'к собственной персоне несколько иронично, а вот от других требуют серьезности.' }
  end

  specify '#definition_sign_console' do
    zodiac_stub = instance_double described_class

    allow(zodiac_stub).to receive(:definition_sign_console)
      .and_return({ 'number' => '12', 'sign_ru' => 'Рыбы', 'dates' => '20.02..20.03', 'text' => '' })

    expect(zodiac_stub.definition_sign_console).to be_a(Hash)

    expect(zodiac_stub.definition_sign_console['sign_ru']).to eq('Рыбы')
  end

  describe '#initialize' do
    it 'setting variable source when "date" is present' do
      zodiac = described_class.new(date: date)

      expect(zodiac).to be_a described_class

      expect(zodiac.instance_variable_get(:@date)).to be date

      expect(zodiac.instance_variable_get(:@signs)).to eq(sign)

      expect(zodiac.instance_variable_get(:@definition)).to eq(body)
    end
  end

  describe '#definition_sign_hands' do
    subject(:zodiac) { described_class.new(date: '31.12.2012') }

    it 'incorrect date format specified' do
      expect { zodiac.definition_sign_hands }
        .to raise_error(AstrologicalForecast::IncorrectDate, /Указан некорректный формат/)
    end
  end

  describe '#sign' do
    it 'has a number, sign_ru, dates and text key in the hash' do
      expect(sign.keys)
        .to eq %w[aries taurus gemini cancer lion virgo libra scorpio sagittarius capricorn aquarius pisces]

      expect(sign['pisces']['number']).to eq '12'

      expect(sign['pisces']['sign_ru']).to eq 'Рыбы'

      expect(sign['pisces']['dates']).to eq '20.02..20.03'

      sign['pisces']['text'] =~ /Одна из самых занятных особенностей Рыб/
    end
  end
end
