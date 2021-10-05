module MeetingRooms
  class GetAllAndFilter < Operation
    def initialize(
      repository: MeetingRoomBooking.new,
      company_repository: Company.new
    )
      @repository = repository,
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
        .or{fail_with_not_found(message: "Company with ID: #{input.fetch(:company_id)} not found")}
    end

    def find_available_meeting_rooms(input)
      p "MeetingRooms::GetAllAndFilter - find_available_meeting_rooms"
      meeting_rooms = @repository.find_meeting_room_by_company_id(company_id: input.fetch(:company_id))
      Success(input.merge(meeting_rooms: meeting_rooms))
    end
  end
end
