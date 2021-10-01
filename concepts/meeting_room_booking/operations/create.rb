class MeetingRoomBooking
  class Create < Operation
    def initialize(
      repository: TransactionRepository.new,
    )
      @repository = repository
      super
    end
=begin
{
 user_id:,
 meeting_room_id:,
 booked_starts_at:,
 booked_ends_at:,
}
=end

    step :validate
    step :verify_meeting_room_availability
    step :persist
    step :serialize
  end
end
