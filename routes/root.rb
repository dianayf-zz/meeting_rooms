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
    end

    handle 404 do
      fail_with_not_found
    end
  end
end
