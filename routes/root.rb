%W(meeting_rooms).each do |router| 
  require_relative router
end

module Routers
  Root = Syro.new do
    on "fail" do
      post { Dry::Monads::Result::Failure.new("")[] }
    end

    on "v1" do
      on ("meeting_rooms") { run MeetingRooms::Public }
      on ("meeting_rooms_booking") { run MeetingRoomBookings::Public }
    end

    handle 404 do
      Failure(type: :not_found, reason: "No encontrada")
    end
  end
end
