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
  get '/test' do
    { message: 'Hello world!' }.to_json
  end

  get '/riders/:id/payment_method' do
    rider = Rider.find(params[:id])
    rider.register_payment(rider.payment_method)
  end
end
