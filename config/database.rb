require 'sequel'
require 'hanami/model'
require 'hanami/model/sql'

Sequel.extension :pg_array, :pg_json, :migration, :pg_array_ops
Hanami::Model.configure do
  adapter :sql, ENV['DATABASE_URL']
end

