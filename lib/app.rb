require 'sinatra'
require 'sinatra/namespace'
require_relative '../config/application'

before do
  content_type :json
end

after do
  ActiveRecord::Base.connection.close
end

namespace '/api/v1' do
  get '/' do
    {
      message: 'Welcome to the API',
      endpoints: [
        "/riders/:id/payment_method",
        "/riders/:id/request_ride",
        "/rides/:id"
      ],
      riders: Rider.all,
      drivers: Driver.all,
      rides: Ride.all
    }.to_json
  end

  get '/riders/:id/payment_method' do
    rider = Rider.find(params[:id])
    rider.register_payment(rider.payment_method)
  end

  get '/riders/:id/request_ride' do
    rider = Rider.find(params[:id])
    rider.request_ride(rider.location)
  end

  get '/rides' do
    Ride.all.to_json
  end

  get '/rides/:id' do
    ride = Ride.find(params[:id])
    total = ride.driver.finish_ride(params[:id])
    {
      message: "Ride finished",
      total: total
    }.to_json
  end
end
