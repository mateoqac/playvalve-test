FactoryBot.define do
  factory :user do
    idfa { SecureRandom.uuid }
    ban_status { [0, 1].sample }
  end
end
