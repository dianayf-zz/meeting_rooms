module MeetingRoomsRoutes
  Public = Syro.new do
    get do
      operation = MeetingRooms::GetAllFiltered.new
      handle_result operation.call(operation_input), success_status: :ok
    end
  end
end
