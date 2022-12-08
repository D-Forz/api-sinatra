FactoryBot.define do
  factory :ride do
    rider
    driver
    origin { { lat: 6.17, lng: -75.58 } }
    destination { { lat: 6.26, lng: -75.58 } }
  end
end
