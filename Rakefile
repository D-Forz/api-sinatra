require 'active_record'

task :default do
  sh 'bundle exec ruby lib/app.rb'
end

namespace :db do
  db_config = YAML.load(File.open("config/database.yml"))
  db_config_admin = db_config.merge({ 'database' => 'postgres', 'schema_search_path' => 'public' })

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.create_database(db_config["database"])
    puts "Database created"
  end

  desc "Migrate the database"
  task migrate: :create do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new("db/migrate/", ActiveRecord::SchemaMigration).migrate
    Rake::Task["db:schema"].invoke
    puts "Database migrated"
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted"
  end

  desc "Reset the database"
  task reset: %i[drop create migrate]

  desc "Create a db/schema.rb file"
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require "active_record/schema_dumper"
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
    puts 'Schema dumped'
  end

  desc 'Populate the database'
  task :seed do
    ActiveRecord::Base.establish_connection(db_config)
    load 'db/seed.rb' if File.exist?('db/seed.rb')
  end

  task :rollback do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new("db/migrate/").rollback
    Rake::Task["db:schema"].invoke
    puts "Last migration has been reverted."
  end
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.write(path, <<~BODY)
      class #{migration_class} < ActiveRecord::Migration[7.0]
        def change
        end
      end
    BODY

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
