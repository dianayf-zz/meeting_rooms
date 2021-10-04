class MeetingRoomBooking
  class Create < Operation
    def initialize(
      repository: MeetingRoomsBooking,
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
      p  "MeetingRoomBooking::Create - validate"
      schema = MeetingRoomBookingCreate
      check_schema_validation schema.call(input)
    end

    def find_user(input)
      p "MeetingRoomBooking::Create - find_user"
      @user_repository.find_by_id(input.fetch(:user_id))
        .bind(-> user {
          Success(input.merge(user: user.to_hash))
        })
        .or{fail_with_not_found(message: "User with ID: #{input.fetch(:user_id)} not found")}
    end

    def find_meeting_room(input)
      p "MeetingRoomBooking::Create - find_meeting_room"
      @meeting_room_repository.find_by_id(input.fetch(:meeting_room_id))
        .bind(-> room {
          Success(input.merge(meeting_room: room.to_hash))
        })
        .or{fail_with_not_found(message: "Meeting room with ID: #{input.fetch(:meeting_room_id)} not found")}
    end

    def check_rooms_company_allowance(input)
      p "MeetingRoomBooking::Create - check_rooms_company_allowance"
      if input.dig(:user, :company_id) == input.dig(:meeting_room, :company_id)
        Success(input)
      else
        fail_with_forbidden(message: "Meeting room does not belongs to your company")
      end
    end

    def verify_meeting_room_availability(input)
      p "MeetingRoomBooking::Create - verify_meeting_room_availability"
      @repository.find_active_booking_by_room_and_date(
        meeting_room_id: input.fetch(:meeting_room_id),
        booked_starts_at: input.fetch(:booked_starts_at),
        booked_ends_at: input.fetch(:booked_ends_at),
        )
        .bind(-> _ { Success(input)} )
        .or{fail_with_validation_error(meeting_room_id: "Meeting room has already booked")}
    end

    def create_booking(input)
      p "MeetingRoomBooking::Create - create_booking"
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
        p "MeetingRoomBooking::Create - create_booking - ERROR"
        internal_failure(reason: "La sala no pudo ser agendada")
      end
    end

    def serialize(input)
      p "MeetingRoomBooking::Create - serialize"
       Success(input.fetch(:meeting_room_booking))
    end
  end
end
