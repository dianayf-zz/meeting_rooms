module MeetingRooms
  class GetAllAndFilter < Operation
    def initialize(
      repository: MeetingRoom,
      company_repository: Company
    )
      @repository = repository
      @company_repository = company_repository
      super
    end

    step :validate
    step :find_company
    map :find_available_meeting_rooms

    private

    def validate(input)
      p  "MeetingRooms::GetAllAndFilter - validate"
      schema = MeetingRoomGetAllAndFilter
      check_schema_validation schema.call(input)
    end

    def find_company(input)
      p "MeetingRoomsBookings::Create - find_company"
      @company_repository.find_by_id(input.fetch(:company_id))
        .bind(-> company {
          Success(input.merge(company: company.to_hash))
        })
        .or{fail_with_not_found(reason: "Company with ID: #{input.fetch(:company_id)} not found")}
    end

    def find_available_meeting_rooms(input)
      p "MeetingRooms::GetAllAndFilter - find_available_meeting_rooms"
      meeting_rooms = @repository.find_meeting_room_by_company_id(company_id: input.fetch(:company_id))
      meeting_rooms.map do |m_room|
        status = get_current_room_status(m_room)
        {
          id: m_room.id,
          max_capacity: m_room.max_capacity,
          created_at: m_room.created_at,
          status: status
        }
      end
    end

    def get_current_room_status(m_room)
      currently_booked_count = m_room.meeting_room_bookings.select do |booked| 
        booked.status == MeetingRoomBookings::Statuses::BOOKED
      end.count
      currently_booked_count > 0 ? MeetingRoomBookings::Statuses::BOOKED : MeetingRooms::Statuses::AVAILABLE
    end
  end
end
