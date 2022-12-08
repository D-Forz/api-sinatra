FactoryBot.define do
  factory :rider do
    username { 'rider' }
    password { 'rider' }
    email { 'rider@example.com' }
    location { { lat: 6.17, lng: -75.58 } }
    payment_method { 'CARD' }
    status { 'AVAILABLE' }
  end
end
