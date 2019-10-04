FactoryBot.define do
  factory :equipment do
    name { Faker::Device.model_name }
    type_equipment
    serial_number { Faker::Device.serial }
  end

  factory :invalid_equipment, class: 'Equipment' do
    name { nil }
    type_equipment { nil }
    serial_numner { nil }
  end
end
