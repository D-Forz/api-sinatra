# API Sinatra

A simple api created with sinatra to emulate a ride-hailing service.

## Run Locally

To run this project, you will need to add the following environment variables to your `.env` file

`APP_PUBLIC_TOKEN`
`APP_PRIVATE_TOKEN`
`TOKENIZED_CARD`
`CARD_ID`

also, be sure to change the `config/database.yml` according to your environment.

Clone the project
```bash
  git clone https://github.com/D-Forz/api-sinatra
```

Go to the project directory
```bash
  cd api-sinatra
```

Install dependencies
```bash
  bundle install
```

Start the server
```bash
  bundle exec ruby lib/app.ruby
```

### with docker

Clone the project
```bash
  git clone https://github.com/D-Forz/api-sinatra
```

Go to the project directory
```bash
  cd api-sinatra
```
Build and run the docker container
```bash
  docker compose up --build
```

## Running Tests

To run all the tests in local, run the following command
```bash
  rspec
```

to run individual specs
```bash
  rspec 'path_to_the_file"
```

### in docker

Open the bash console in docker and run the previous commands.
```bash
  docker compose run api bash
```
