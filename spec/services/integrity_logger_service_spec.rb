require 'rails_helper'

RSpec.describe IntegrityLoggerService do
  describe '.log' do
    let(:user) { instance_double(User, idfa:, ban_status:) }
    let(:ban_status) { 'not_banned' }
    let(:idfa) { SecureRandom.uuid }
    let(:params) { { ip: '192.168.1.1', rooted_device: false, country: 'Argentina', proxy: false, vpn: true } }

    before do
      allow(IntegrityLog).to receive(:create)
    end

    it 'creates a new integrity log' do
      described_class.log(user:, params:)

      expect(IntegrityLog).to have_received(:create).with(
        idfa:,
        ban_status:,
        ip: '192.168.1.1',
        rooted_device: false,
        country: 'Argentina',
        proxy: false,
        vpn: true
      )
    end
  end
end
