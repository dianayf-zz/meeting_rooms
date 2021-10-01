Sequel.migration do
  change do
    create_table :meeting_rooms do
      primary_key :id
      column :max_capacity, Integer, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :company_id, :companies, null: false
    end
  end
end
