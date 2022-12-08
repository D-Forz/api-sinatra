require_relative '../helpers/utils'
class Driver < ActiveRecord::Base
  include Utils
  has_many :rides

  validates :username, presence: true, uniqueness: true
  validates :password, :location, presence: true
  validates :status, inclusion: { in: %w[AVAILABLE RIDE] }

# •	Finish a ride: Given its ID and final location (assume the ride is a straight line in the map). It must immediately:
# •	Calculate the total amount to be paid, given these fees:
# COP $1000 for each km
# COP $200 for every minute elapsed
# COP $3500 base fee, added always
# •	Create a transaction, using the Wompi API and charging the user the total amount

  def finish_ride(ride_id)
    ride = Ride.find(ride_id)
    return {message: 'You are not in a ride'}.to_json unless ride.driver == self

    ride.update(destination: { lat: 6.25, lng: -75.58 }) # TODO: change to final location
    self.update(status: 'AVAILABLE')

    distance = distance(ride.origin, ride.destination)
    time = ((ride.updated_at - ride.created_at) / 60).round(2)
    total = ((distance * 1000) + (time * 200) + 3500).round(2)

    body = {
      amount_in_cents: total.to_i,
      currency: 'COP',
      customer_email: ride.rider.email,
      payment_method: {
        installments: 2
      },
      reference: "Ride#{ride.id}",
      payment_source_id: ENV.fetch('CARD_ID').to_i
    }

    response = HTTParty.post(
      'https://sandbox.wompi.co/v1/transactions',
      body: body.to_json,
      headers: { "Authorization": "Bearer #{ENV.fetch('APP_PRIVATE_TOKEN')}" }
    )

    return total
  end
end
