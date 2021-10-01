class MeetingRoomBooking
  class Create < Operation
    def initialize(
      repository: MeetingRoomBookingRepository.new
    )
      @meeting_room_booking_repository = repository
      super
    end

    step :validate
    step :verify_meeting_room_availability
    step :persist
    step :serialize

    private

    def validate(input)
      p  "MeetingRoomBooking::Create - validate"
      schema = MeetingRoomBookingSchema.new
      check_schema_validation schema.call(input)
    end

    def verify_meeting_room_availability(input)
      p "MeetingRoomBooking::Create - verify_meeting_room_availability"
        Success(input)
    end
  end
end
