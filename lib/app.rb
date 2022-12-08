require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/reloader'
require_relative '../config/application'


class ApiSinatra < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Namespace

  before do
    content_type :json
  end

  after do
    ActiveRecord::Base.connection.close
  end

  get '/' do
    redirect to "/api/v1/"
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
      rider.register_payment(rider.payment_method, rider.get_acceptance_token)
    end

    get '/riders/:id/request_ride' do
      rider = Rider.find(params[:id])
      driver = Driver.where(status: 'AVAILABLE').first
      rider.request_ride(rider.location, driver)
    end

    get '/rides' do
      Ride.all.to_json
    end

    get '/rides/:id' do
      redirect to "/api/v1/" unless Ride.exists?(params[:id])

      ride = Ride.find(params[:id])
      body = ride.driver.finish_ride(params[:id])
      ride.driver.create_transaction(body)
      {
        message: "Ride finished",
        total: body[:amount_in_cents]
      }.to_json
    end
  end
  run! if app_file == $PROGRAM_NAME
end
