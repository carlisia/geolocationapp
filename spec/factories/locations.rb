require 'faker'

FactoryGirl.define do
        
  point = "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})"
  factory :location do
    name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    postal_code_name { Faker::Address.zip_code }
    postal_code_suffix { [1,2,3,4].shuffle }
    phone_number { Faker::PhoneNumber.phone_number }
    latlon { point }
    radius { 5 }

    factory :invalid_location do
      name nil
    end
  end
end