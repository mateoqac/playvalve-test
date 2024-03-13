require 'rails_helper'

RSpec.describe VpnApiService do
  subject(:service) { described_class.new(ip_address) }

  let(:ip_address) { Faker::Internet.ip_v4_address }
  let(:http_request_double) { instance_double(HttpRequest) }

  let(:base_url) { 'https://url.com/api/' }
  let(:api_key) { 'any_api_key_value' }

  before do
    allow(ENV).to receive(:fetch).with('VPN_API_URL').and_return(base_url)
    allow(ENV).to receive(:fetch).with('VPN_API_KEY').and_return(api_key)
    allow(HttpRequest).to receive(:new).and_return(http_request_double)
  end

  describe '#perform' do
    context 'when HttpRequest succeeds' do
      let(:response_double) { instance_double(HttpResponse) }

      before do
        allow(http_request_double).to receive(:send_request).and_return(response_double)
      end

      it 'calls HttpRequest with correct URL' do
        expect(http_request_double).to receive(:send_request).once
        service.perform
      end
    end

    context 'when HttpRequest fails' do
      before do
        allow(http_request_double).to receive(:send_request).and_raise(StandardError)
      end

      it 'raises an error' do
        expect { service.perform }.to raise_error(StandardError)
      end
    end
  end
end
