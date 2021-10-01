Sequel.migration do
  change do
    create_table(:companies) do
      primary_key :id
      String :name, :text=>true, :null=>false
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:meeting_rooms) do
      primary_key :id
      Integer :max_capacity, :null=>false
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      foreign_key :company_id, :companies, :null=>false, :key=>[:id]
    end
    
    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id
      String :name, :text=>true, :null=>false
      foreign_key :company_id, :companies, :key=>[:id]
      
      index [:company_id]
    end
    
    create_table(:meeting_room_bookings, :ignore_index_errors=>true) do
      primary_key :id
      foreign_key :user_id, :users, :key=>[:id]
      foreign_key :meeting_room_id, :meeting_rooms, :key=>[:id]
      DateTime :created_at, :null=>false
      DateTime :updated_at, :null=>false
      DateTime :booked_starts_at, :null=>false
      DateTime :booked_ends_at, :null=>false
      String :status, :text=>true
      
      index [:meeting_room_id]
      index [:user_id]
    end
  end
end
