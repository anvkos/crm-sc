FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    password { 'q1w2e3' }
    password_confirmation { 'q1w2e3' }
  end
end
