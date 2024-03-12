require 'rails_helper'

RSpec.describe IntegrityLog, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:idfa) }
    it { should validate_presence_of(:ban_status) }
  end

  describe 'associations' do
    it { should belong_to(:user).with_foreign_key(:idfa) }
  end
end
