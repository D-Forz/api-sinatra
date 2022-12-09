# API Sinatra

A simple api created with sinatra to emulate a ride-hailing service.




## Run Locally

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

Start the server(remember to change the host in `config/database.yml`)

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
Clone the project

```bash
  docker compose up --build
```

## Running Tests

To run all the tests, run the following command

```bash
  rspec
```

to run individual specs

```bash
  rspec 'path_to_the_file"
```