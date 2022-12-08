FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir /api-sinatra
WORKDIR /api-sinatra

COPY Gemfile /api-sinatra/Gemfile

RUN bundle install

EXPOSE 4567

COPY . /api-sinatra
