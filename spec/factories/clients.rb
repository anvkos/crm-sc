FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    password { 'q1w2e3' }
    password_confirmation { 'q1w2e3' }
    fullname { Faker::Name.name }
    phone { Faker::PhoneNumber.subscriber_number(length: 11) }
  end
end
