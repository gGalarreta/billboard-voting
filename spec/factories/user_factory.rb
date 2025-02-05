require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: 'testing.com') }
    password { 'test1234' }
  end
end
