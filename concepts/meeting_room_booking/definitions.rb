class MeetingRoomBooking < Hanami::Entity
  attributes do
    attribute :id, Types::Strict::Int
    attribute :created_at, Types::Time
    attribute :created_at, Types::Time
    attribute :booked_start_at, Types::Time
    attribute :booked_ends_at, Types::Time
    attribute :meeting_room_id, Types::Strict::Int
    attribute :user_id, Types::Strict::Int
    attribute :status, Types::Strict::String
  end
end

