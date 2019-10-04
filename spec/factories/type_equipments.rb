FactoryBot.define do
  factory :type_equipment do
    name { Faker::Device.platform }
  end
end
