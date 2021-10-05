MeetingRoomGetAllAndFilter = Dry::Schema.Params do
  DATETIME_FORMAT = /[12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]) (2[0-3]|[01][0-9])(:[0-5][0-9]){2}/
  required(:company_id).filled(Types::Coercible::String)
  optional(:booked_starts_at).filled(format?: DATETIME_FORMAT)
  optional(:booked_ends_at).filled(:string, format?: DATETIME_FORMAT)
end
