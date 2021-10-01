module MeetingRooms
  Public = Syro.new do
    get do
      operation = MeetingRoom::GetAllFiltered.new
      handle_result operation.call(operation_input), success_status: :OK
    end
  end
end
