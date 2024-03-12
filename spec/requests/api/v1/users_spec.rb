require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /check_status' do
    let(:params) { { idfa:, rooted_device: false } }

    subject(:make_request) { post('/api/v1/users/check_status', params:) }

    context 'when user is not found by idfa' do
      let(:idfa) { SecureRandom.uuid }

      context 'when it passes security checks' do
        before do
          allow_any_instance_of(Api::V1::UsersController).to receive(:security_checks_result).and_return('not_banned')
          make_request
        end

        it 'creates a new user and sets ban_status after running security checks' do
          expect(response).to have_http_status(:success)
          expect(json_response).to eq('ban_status' => 'not_banned')

          created_user = User.last
          expect(created_user.idfa).to eq(idfa)
          expect(created_user.ban_status).to eq('not_banned')
        end

        it 'creates a new entry for the IntegrityLog' do
          expect(IntegrityLog.count).to eq(1)
        end
      end
    end
    context 'when user is found by idfa' do
      let(:idfa) { user.idfa }
      context 'when user is banned' do
        let(:user) { create(:user, ban_status: 'banned') }
        it 'returns ban_status: "banned"' do
          make_request

          expect(response).to have_http_status(:success)
          expect(json_response).to eq('ban_status' => 'banned')
        end
      end

      context 'when user is not banned' do
        let(:user) { create(:user, ban_status: 'not_banned') }
        context 'when security check pass' do
          it 'returns "not_banned"' do
            allow_any_instance_of(Api::V1::UsersController).to receive(:security_checks_result).and_return('not_banned')

            make_request
            expect(response).to have_http_status(:success)
            expect(json_response).to eq('ban_status' => 'not_banned')
          end

          it 'does not create a new entry on logs' do
            allow_any_instance_of(Api::V1::UsersController).to receive(:security_checks_result).and_return('not_banned')

            expect { make_request }.not_to(change { IntegrityLog.count })
          end
        end

        context 'when security check fails' do
          before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:security_checks_result).and_return('banned')
            make_request
          end

          it 'returns "banned"' do
            expect(response).to have_http_status(:success)
            expect(json_response).to eq('ban_status' => 'banned')
          end

          it 'does create a new entry on logs' do
            expect(IntegrityLog.count).to eq(1)
          end
        end
      end
    end
  end
end
