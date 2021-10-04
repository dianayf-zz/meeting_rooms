class MeetingRoomBookingSerializer < Dry::Struct
=begin
  attribute :status,
  attribute :user, Types::Strict::Int
  attribute :company_id, Types::Strict::Int
  attribute :booked_starts_at, Types::Time
  attribute :booked_ends_at, Types::Time
=end
end
