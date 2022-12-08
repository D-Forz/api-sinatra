FactoryBot.define do
  factory :driver do
    username { 'driver' }
    password { 'driver' }
    status { 'AVAILABLE' }
    location { { lat: 6.17, lng: -75.58 } }
  end
end
