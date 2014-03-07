require 'faker'

FactoryGirl.define do
        
  factory :location do
    lat, lng = location_array.pop
    name { Faker::Company.name }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    postal_code_name { Faker::Address.zip_code }
    postal_code_suffix { [1,2,3,4].shuffle }
    phone_number { Faker::PhoneNumber.phone_number }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    radius { 5 }

    factory :invalid_location do
      name nil
    end
  end
end