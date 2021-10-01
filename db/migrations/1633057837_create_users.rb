Sequel.migration do
  change do
    create_table :users do
      primary_key :id

      column :name, String, text: true, null: false
      column :company_id, Integer, index: true

      foreign_key [:company_id], :companies
    end
  end
end

