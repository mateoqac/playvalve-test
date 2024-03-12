require 'rails_helper'

RSpec.describe RedisService do
  describe '.instance' do
    subject(:instance) { RedisService.instance }
    context 'when Redis is available' do
      it 'returns a Redis instance' do
        expect(instance).to be_a(Redis)
      end
    end

    context 'when Redis is not available' do
      before do
      end

      it 'logs an error' do
        allow(Redis).to receive(:new).and_raise(Redis::BaseConnectionError)
        expect(Rails.logger).to receive(:error).with(/Error connecting to Redis/)
        instance
      end
    end
  end
end
