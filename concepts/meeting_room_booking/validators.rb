MeetingRoomBookingCreate = Dry::Schema.Params do
  DATE_FORMAT = /[12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])/

  required(:user_id).filled(:string)
  required(:meeting_room_id).filled(:string)
  required(:booked_starts_at).filled(format?: DATE_FORMAT)
  required(:booked_ends_at).filled(:string, format?: DATE_FORMAT)
end
