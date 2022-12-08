class Rider < ActiveRecord::Base
  has_many :rides

  validates :username, presence: true
  validates :password, :location, presence: true
  validates :status, inclusion: { in: %w[AVAILABLE RIDE] }

  BASE_URL = 'https://sandbox.wompi.co/v1/'

  def register_payment(method, acceptance_token)
    body = {
      type: self.payment_method,
      token: ENV.fetch('TOKENIZED_CARD'),
      customer_email: self.email,
      acceptance_token: acceptance_token
    }
    HTTParty.post(
      "#{BASE_URL}payment_sources",
      body: body.to_json,
      headers: { "Authorization": "Bearer #{ENV.fetch('APP_PUBLIC_TOKEN')}" }
    )
  end

  def get_acceptance_token
    HTTParty.get(
      "#{BASE_URL}merchants/#{ENV.fetch('APP_PUBLIC_TOKEN')}")
        .parsed_response['data']['presigned_acceptance']['acceptance_token']
  end

  def request_ride(origin, driver)
    return {message: 'No available drivers'}.to_json unless driver.status == 'AVAILABLE'

    ride = Ride.create(origin: { lat: origin['lat'], lng: origin['lng'] }, rider: self)
    ride.update(driver: driver)
    driver.update(status: 'RIDE')
    self.update(status: 'RIDE')
    return ride.to_json
  end
end
