module MeetingRoomBookingRoutes
  Public = Syro.new(API::Wrapper) do
    post do
      parse_json_body
      operation = MeetingRoomBookings::Create.new
      result  = operation.call(inbox[:body])
      handle_result result, success_status: :created
    end
  end
end
