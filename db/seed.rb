require_relative '../app/models/rider'
require_relative '../app/models/driver'

rider = Rider.new(
  username: 'rider',
  password: 'rider',
  email: 'rider@example.com',
  location: { lat: 6.17, lng: -75.58 },
  payment_method: 'CARD',
  status: 'AVAILABLE'
)
rider.save

p "Rider created with id: #{rider.id}"

driver = Driver.new(
  username: 'driver',
  password: 'driver',
  status: 'AVAILABLE',
  location: { lat: 6.17, lng: -75.58 }
)
driver.save

p "Driver created with id: #{driver.id}"
