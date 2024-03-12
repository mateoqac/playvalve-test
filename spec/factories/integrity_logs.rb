FactoryBot.define do
  factory :integrity_log do
    idfa { SecureRandom.uuid }
    ban_status { [0, 1].sample }
    ip { Faker::Internet.ip_v4_address }
    rooted_device { false }
    country { Faker::Address.country }
    proxy { false }
    vpn { false }
  end
end
