Sequel.migration do
  change do
    create_table :companies do
      primary_key :id
      column :name, String, text: true, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
