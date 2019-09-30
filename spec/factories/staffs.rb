FactoryBot.define do
  factory :staff do
    email { Faker::Internet.email }
    password { 'q1w2e3' }
    password_confirmation { 'q1w2e3' }
    fullname { Faker::Name.name }
  end
end
