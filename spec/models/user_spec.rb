require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a ban_status' do
    user = build(:user, ban_status: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid with an used idfa' do
    user = create(:user)
    new_user = build(:user, idfa: user.idfa)
    expect(new_user).not_to be_valid
  end

  it 'is valid with a right format of idfa' do
    user = build(:user, idfa: SecureRandom.uuid)
    expect(user).to be_valid
  end

  it 'is not valid with a wrong format of idfa' do
    user = build(:user, idfa: 'wrong_format')
    expect(user).not_to be_valid
  end

  it 'returns a message with a wrong format of idfa' do
    user = build(:user, idfa: 'wrong_format')
    user.valid?

    expect(user.errors[:idfa]).to include('Not a valid UUID')
  end
end
