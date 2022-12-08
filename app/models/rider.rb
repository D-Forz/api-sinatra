class Rider < ActiveRecord::Base
  has_many :rides

  validates :username, presence: true, uniqueness: true
  validates :password, :location, presence: true
  validates :status, inclusion: { in: %w[AVAILABLE RIDE] }

  def register_payment(method)
    base_url = 'https://sandbox.wompi.co/v1/'
    acceptance_token = HTTParty.get(
      "#{base_url}merchants/#{ENV.fetch('APP_PUBLIC_TOKEN')}")
        .parsed_response['data']['presigned_acceptance']['acceptance_token']
    body = {
      type: self.payment_method,
      token: ENV.fetch('TOKENIZED_CARD'),
      customer_email: self.email,
      acceptance_token: acceptance_token
    }

    HTTParty.post(
      "#{base_url}payment_sources",
      body: body.to_json,
      headers: { "Authorization": "Bearer #{ENV.fetch('APP_PUBLIC_TOKEN')}" }
    )
  end

  def request_ride(origin)
    driver = Driver.where(status: 'AVAILABLE').first
    return {message: 'No available drivers'}.to_json unless driver

    ride = Ride.create(origin: { lat: origin['lat'], lng: origin['lng'] }, rider: self)
    ride.update(driver: driver)
    driver.update(status: 'RIDE')
    self.update(status: 'RIDE')
    return ride
  end
end
