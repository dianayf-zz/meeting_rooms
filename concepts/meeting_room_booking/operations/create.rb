module MeetingRoomBookings
  class Create < Operation
    def initialize(
      repository: MeetingRoomBooking,
      user_repository: User,
      meeting_room_repository: MeetingRoom
    )
      @repository = repository
      @user_repository = user_repository
      @meeting_room_repository = meeting_room_repository
      super
    end

    step :validate
    step :find_user
    step :find_meeting_room
    step :check_rooms_company_allowance
    step :verify_meeting_room_availability
    step :create_booking
    map :serialize

    private

    def validate(input)
      p  "MeetingRoomsBookings::Create - validate"
      schema = MeetingRoomBookingCreate
      check_schema_validation schema.call(input)
    end

    def find_user(input)
      p "MeetingRoomsBookings::Create - find_user"
      @user_repository.find_by_id(input.fetch(:user_id))
        .bind(-> user {
          Success(input.merge(user: user.to_hash))
        })
        .or{fail_with_not_found(message: "User with ID: #{input.fetch(:user_id)} not found")}
    end

    def find_meeting_room(input)
      p "MeetingRoomsBookings::Create - find_meeting_room"
      @meeting_room_repository.find_by_id(input.fetch(:meeting_room_id))
        .bind(-> room {
          Success(input.merge(meeting_room: room.to_hash))
        })
        .or{fail_with_not_found(message: "Meeting room with ID: #{input.fetch(:meeting_room_id)} not found")}
    end

    def check_rooms_company_allowance(input)
      p "MeetingRoomsBookings::Create - check_rooms_company_allowance"
      if input.dig(:user, :company_id) == input.dig(:meeting_room, :company_id)
        Success(input)
      else
        fail_with_forbidden(reason: "Meeting room does not belongs to your company")
      end
    end

    def verify_meeting_room_availability(input)
      p "MeetingRoomsBookings::Create - verify_meeting_room_availability"
      already_booked = @repository.active_booking_by_room_and_date?(
        meeting_room_id: input.fetch(:meeting_room_id),
        booked_starts_at: input.fetch(:booked_starts_at),
        booked_ends_at: input.fetch(:booked_ends_at),
        )
      already_booked ? fail_with_unprocessable(reason: "Meeting room has already booked during this timeslots") : Success(input)
    end

    def create_booking(input)
      p "MeetingRoomsBookings::Create - create_booking"
      booking = @repository.new(
        user_id: input.fetch(:user_id),
        meeting_room_id: input.fetch(:meeting_room_id),
        booked_starts_at: input.fetch(:booked_starts_at),
        booked_ends_at: input.fetch(:booked_ends_at),
        status: MeetingRoomBookings::Statuses::BOOKED
      )
      if booking.save
        Success(input.merge meeting_room_booking: booking)
      else
        p "MeetingRoomsBookings::Create - create_booking - ERROR"
        internal_failure(reason: "Meeting room could not be booked")
      end
    end

    def serialize(input)
      p "MeetingRoomsBookings::Create - serialize"
      input.fetch(:meeting_room_booking).to_hash
    end
  end
end
