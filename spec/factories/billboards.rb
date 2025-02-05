FactoryBot.define do
  factory :billboard do
    address { Faker::Address.full_address }
    url { Faker::Internet.url }
  end
end
