module MeetingRoomBookings
  Public = Syro.new(API::Deck) do
    post do
      parse_json_body
      operation = MeetingRoomBooking::Create.new
      result  = operation.call(inbox[:body])
      handle_result result, success_status: :OK
    end
  end
end
