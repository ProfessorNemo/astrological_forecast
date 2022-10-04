# frozen_string_literal: true

RSpec.describe AstrologicalForecast::Type do
  let(:types) do
    {
      'Общий' => '1',
      'Любовный' => '2',
      'Семейный' => '3',
      'Карьерный' => '4',
      'Здоровье' => '5',
      'Тинейджер' => '6',
      'Флирт' => '7',
      'Друзья' => '8'
    }
  end

  let(:periods) do
    {
      'На сегодня' => '1',
      'На завтра' => '2',
      'На неделю' => '3',
      'На месяц' => '4',
      'На год' => '5'
    }
  end

  specify '#type_console' do
    type_stub = instance_double described_class

    allow(type_stub).to receive(:type_console)
      .and_return(types['Общий'].to_i)

    expect(type_stub.type_console).to be_a(Integer)
    expect(type_stub.type_console).to eq(1)
  end

  specify '#period_console' do
    period_stub = instance_double described_class

    allow(period_stub).to receive(:period_console)
      .and_return(periods['На сегодня'].to_i)

    expect(period_stub.period_console).to be_a(Integer)
    expect(period_stub.period_console).to eq(1)
  end

  describe '#initialize' do
    it 'setting variable source when "date & period" is present and correct' do
      type = 'Общий'

      period = 'На сегодня'

      zodiac = described_class.new(type: type, period: period)

      expect(zodiac).to be_a described_class
      expect(zodiac.instance_variable_get(:@type)).to eq(zodiac.correct(type))
      expect(zodiac.instance_variable_get(:@period)).to eq(zodiac.correct(period))
      expect(zodiac.instance_variable_get(:@user_type)).to eq(1)
      expect(zodiac.instance_variable_get(:@user_period)).to eq(1)
    end

    describe '#manual_check' do
      it 'incorrect type format specified' do
        type = 'Общественный'
        period = 'На сегодня'
        expect { described_class.new(type: type, period: period).instance_variable_get(:@user_type) }
          .to raise_error(AstrologicalForecast::IncorrectType, /Некорректный тип прогноза/)
      end

      it 'incorrect period format specified' do
        type = 'Общий'
        period = 'сегодня'
        expect { described_class.new(type: type, period: period).instance_variable_get(:@user_period) }
          .to raise_error(AstrologicalForecast::IncorrectPeriod, /Некорректный период прогнозирования/)
      end
    end
  end
end
