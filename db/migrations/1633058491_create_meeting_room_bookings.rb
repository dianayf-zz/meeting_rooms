Sequel.migration do
  change do
    create_table :meeting_room_bookings do
      primary_key :id

      column :user_id, Integer, index: true
      column :meeting_room_id, Integer, index: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :booked_starts_at, DateTime, null: false
      column :booked_ends_at, DateTime, null: false
      column :status, String, text: true

      foreign_key [:user_id], :users
      foreign_key [:meeting_room_id], :meeting_rooms
    end
  end
end

