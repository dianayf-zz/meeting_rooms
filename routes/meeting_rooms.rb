module MeetingRoomsRoutes
  Public = Syro.new(API::Wrapper) do
    get do
      input = get_all_query_params
      operation = MeetingRooms::GetAllAndFilter.new
      handle_result operation.call(input), success_status: :ok
    end
  end
end
