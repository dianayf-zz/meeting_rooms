module MeetingRoomBookings
  Public = Syro.new do
    post do
      operation = MeetingRoomBooking::Create.new
      handle_result operation.call(operation_input), success_status: :OK
    end
  end
end
