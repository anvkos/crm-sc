FactoryBot.define do
  factory :equipment do
    name { Faker::Device.model_name }
    kind { Faker::Device.platform }
    serial_number { Faker::Device.serial }
  end

  factory :invalid_equipment, class: 'Equipment' do
    name { nil }
    kind { nil }
    serial_numner { nil }
  end
end
