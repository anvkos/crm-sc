FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    kind { "ЮЛ" }
    inn { Faker::Number.number(digits: 10) }
    ogrn { Faker::Number.number(digits: 13) }
  end
end
