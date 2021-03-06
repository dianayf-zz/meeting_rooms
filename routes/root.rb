module Routers
  Root = Syro.new do
    on "fail" do
      post { Dry::Monads::Result::Failure.new("")[] }
    end

    on "v1" do
      on ("meeting_rooms") { run MeetingRoomsRoutes::Public }
      on ("meeting_rooms_bookings") { run MeetingRoomBookingRoutes::Public }
    end

    handle 404 do
      Failure(type: :not_found, reason: "Not found")
    end
  end
end
