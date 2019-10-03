FactoryBot.define do
  factory :equipment do
    name { Faker::Device.model_name }
    kind { Faker::Device.platform }
    serial_number { Faker::Device.serial }
  end
end
