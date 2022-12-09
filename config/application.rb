require 'active_record'
require 'httparty'
require 'dotenv/load'

# Require all the ruby files you have created in `models`
dir = File.dirname(__FILE__)
Dir[File.join(dir, '../app/models/*.rb')].each { |file| require file }

# Initialize the database
db_config = YAML.load(File.open("config/database.yml"), aliases: true)
ActiveRecord::Base.establish_connection(db_config["default"])

# Set a logger so that you can view the SQL actually performed by Active Record

# logger = Logger.new($stdout)
# logger.formatter = proc do |_severity, _datetime, _progname, msg|
#   "#{msg}\n"
# end
# ActiveRecord::Base.logger = logger
