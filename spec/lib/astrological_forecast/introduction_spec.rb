# frozen_string_literal: true

BASE_URL = 'https://orakul.com/'

RSpec.describe AstrologicalForecast::Introduction do
  let(:vars) do
    { number: nil, name_ru: nil, name_en: 'pisces', type: 'general', time: 'today' }
  end

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

  it 'can fetch & parse user data' do
    uri = Addressable::URI.parse(BASE_URL)
    response = VCR.use_cassette('source') do
      Net::HTTP.get_response(uri).body
    end

    response = response.force_encoding('UTF-8')
    document = Nokogiri::HTML(response)
    zodiac = document.css('div.main ul > li')[vars[:number].to_i - 1]

    source = {
      name: zodiac.at('a .name').text,
      date: zodiac.at('a .per').text,
      head: zodiac.css(".ico-#{vars[:name_en]}")
                  .text.strip.gsub(/\s{2,}/, ', ')
                  .split(', ')[2]
    }

    expect(uri.scheme).to eq('https')
    expect(uri.host).to eq('orakul.com')
    expect(uri.path).to eq('/')
    expect(uri.normalize == uri).to be(true)
    expect(response).to be_a(String)

    expect(source.keys).to contain_exactly(:date, :head, :name)
    expect(source[:name]).to eq 'Рыбы'
    expect(source[:date]).to eq 'Февраль 20 - Март 20'
    expect(source[:head]).to eq 'Я верю! Ключевая особенность - мечтательность.'
  end
end
