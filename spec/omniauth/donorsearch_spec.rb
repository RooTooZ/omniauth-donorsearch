require 'spec_helper'

describe OmniAuth::Strategies::Donorsearch do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  before do
    OmniAuth.config.test_mode = true
  end

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Donorsearch.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('donorsearch')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://id.donorsearch.org')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end
  end

  describe 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the nickname' do
      expect(subject.info[:nickname]).to eq(raw_info_hash['nickname'])
    end

    it 'should returns the email' do
      expect(subject.info[:email]).to eq(raw_info_hash['email'])
    end

    it 'should returns the first_name' do
      expect(subject.info[:first_name]).to eq(raw_info_hash['first_name'])
    end

    it 'should returns the last_name' do
      expect(subject.info[:last_name]).to eq(raw_info_hash['last_name'])
    end

    it 'should returns the avatar' do
      expect(subject.info[:avatar]).to eq(raw_info_hash['avatar'])
    end

    it 'should returns the bdate' do
      expect(subject.info[:bdate]).to eq(raw_info_hash['bdate'])
    end

    it 'should returns the gender' do
      expect(subject.info[:gender]).to eq(raw_info_hash['gender'])
    end
  end

  describe 'skip_info option' do
    context 'when skip info option is enabled' do
      it 'should not include raw_info in extras hash' do
        @options = { :skip_info => true }
        allow(subject).to receive(:raw_info).and_return({:foo => 'bar'})
        expect(subject.extra[:raw_info]).to eq(nil)
      end
    end
  end
end

private

def img_url
  'https://id.donorsearch.org/avatar/u1/big.png'
end

def raw_info_hash
  {
      'nickname' => 'best_nickname',
      'email' => 'email@supermain.com',
      'first_name' => 'foo',
      'last_name' => 'bar',
      'avatar' => img_url,
      'bdate' => '19.05.1985',
      'gender' => 'male'
  }
end
