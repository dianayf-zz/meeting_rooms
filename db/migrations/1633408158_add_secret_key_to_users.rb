require 'securerandom'
Sequel.migration do
  change do
    alter_table(:users) do
      add_column :secret_key, String, null: false, unique: true, default: "secret_key_#{SecureRandom.alphanumeric(32)}"
    end
  end
end
