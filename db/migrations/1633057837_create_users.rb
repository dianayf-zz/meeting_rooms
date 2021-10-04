Sequel.migration do
  change do
    create_table :users do
      primary_key :id

      column :first_name, String, text: true, null: false
      column :last_name, String, text: true, null: false
      column :company_id, Integer, index: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key [:company_id], :companies
    end
  end
end

