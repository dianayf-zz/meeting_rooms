MeetingRoomBookingCreates = Dry::Validation.Schema(AppSchema) do
  DATE_FORMAT = /[12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])/

  required(:user_id, :string).filled(:str?)
  required(:meeting_room_id, :string).filled(:str?)
  required(:booked_starts_at, Types::Strict::String).filled(format?: DATE_FORMAT)
  required(:booked_ends_at, Types::Strict::String).filled(format?: DATE_FORMAT)
end
