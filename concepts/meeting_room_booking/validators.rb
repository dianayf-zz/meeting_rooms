MeetingRoomBookingCreate = Dry::Schema.Params do
  DATETIME_FORMAT = /[12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]) (2[0-3]|[01][0-9])(:[0-5][0-9]){2}/

  required(:user_id).filled(Types::Coercible::String)
  required(:meeting_room_id).filled(Types::Coercible::String)
  required(:booked_starts_at).filled(format?: DATETIME_FORMAT)
  required(:booked_ends_at).filled(:string, format?: DATETIME_FORMAT)
end
