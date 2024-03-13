require 'rails_helper'

RSpec.describe VpnApiResponse do
  subject(:service) { described_class.new(response) }
  let(:response_body) { {} }

  describe '#ip' do
    let(:ip_address) { Faker::Internet.ip_v4_address }
    let(:response_body) { { 'ip' => ip_address } }
    let(:response) { instance_double(Net::HTTPSuccess, code: '200', body: response_body.to_json) }

    it 'returns the IP address' do
      expect(service.ip).to eq(ip_address)
    end
  end

  describe '#country' do
    let(:response_body) { { 'location' => { 'country' => 'Spain' } } }
    let(:response) { instance_double(Net::HTTPSuccess, code: '200', body: response_body.to_json) }

    it 'returns the country' do
      expect(service.country).to eq('Spain')
    end
  end

  describe '#proxy' do
    context 'when proxy information is available' do
      let(:response_body) { { 'security' => { 'proxy' => true } } }
      let(:response) { instance_double(Net::HTTPResponse, code: 200, body: response_body.to_json) }

      it 'returns true' do
        expect(service.proxy).to be_truthy
      end
    end

    context 'when proxy information is not available' do
      let(:response) { instance_double(Net::HTTPResponse, code: 200, body: response_body.to_json) }

      it 'returns false' do
        expect(service.proxy).to be_falsey
      end
    end
  end

  describe '#vpn' do
    context 'when VPN information is available' do
      let(:response_body) { { 'security' => { 'vpn' => true } } }
      let(:response) { instance_double(Net::HTTPResponse, code: 200, body: response_body.to_json) }

      it 'returns true' do
        expect(service.vpn).to be_truthy
      end
    end

    context 'when VPN information is not available' do
      let(:response) { instance_double(Net::HTTPResponse, code: '200', body: response_body.to_json) }

      it 'returns false' do
        expect(service.vpn).to be_falsey
      end
    end
  end
end
