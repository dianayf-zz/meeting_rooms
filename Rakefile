require 'rake'
require 'rake/testtask'

task :env do
  require_relative 'boot'
end

task console: :env do
  pry
end

task default: :test
task spec: :test

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require 'bundler'
    Bundler.setup :default
    require "sequel"
    Sequel.extension :migration
    db = Sequel.connect(
      ENV.fetch("DATABASE_URL"),
    )
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
    db.extension :schema_dumper
    schema = db.dump_schema_migration
    target = File.new("db/schema.rb", "w")
    target.write(schema)
    target.close
  end
end
