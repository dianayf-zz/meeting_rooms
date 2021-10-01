require 'sequel'

Sequel.extension :pg_array, :pg_json, :migration, :pg_array_ops
Sequel::Model.db = Sequel.connect(ENV["DATABASE_URL"])

