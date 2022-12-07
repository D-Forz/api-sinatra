require_relative '../app/models/rider'
require_relative '../app/models/driver'

rider = Rider.new(
  username: 'rider',
  password: 'rider',
  email: 'rider@example.com',
  location: { lat: 4.6097100, lng: -74.0817500 },
  payment_method: 'CARD',
  status: 'AVAILABLE'
)
rider.save

p "Rider created with id: #{rider.id}"

driver = Driver.new(
  username: 'driver',
  password: 'driver',
  status: 'AVAILABLE',
  location: { lat: 4.6097100, lng: -74.0817500 }
)
driver.save

p "Driver created with id: #{driver.id}"
