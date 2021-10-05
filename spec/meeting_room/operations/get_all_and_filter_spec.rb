RSpec.describe MeetingRooms::GetAllAndFilter do
  let(:company) {build(:company).save}
  let(:company2) {build(:company, name: "theother").save}
  let(:meeting_room) {build(:meeting_room, company_id: company.id).save}
  let(:meeting_room_external) {build(:meeting_room, company_id: company2.id).save}
  let(:user) {build(:user, company_id: company.id).save}
  let(:meeting_room_booking) do
    build(:meeting_room_booking, user_id: user.id, meeting_room_id: meeting_room.id, status: MeetingRoomBookings::Statuses::FINISHED).save
  end
  let(:repository) {double("MeetingRoomBooking")}
  let(:user_repository) {double("User")}
  let(:meeting_room_repository) {double("MeetingRoom")}

  let(:operation) do
    described_class.new(
      repository: repository,
      user_repository: user_repository,
      meeting_room_repository: meeting_room_repository
    )
  end

  let(:input) do
    {
      user_id: user.id.to_s,
      meeting_room_id: meeting_room.id.to_s,
      booked_starts_at: "2021-09-29 10:00:00",
      booked_ends_at: "2021-09-29 10:30:00"
   }
  end

  before do
    allow(user_repository).to receive(:find_by_id) {Dry::Monads::Some(user)}
    allow(meeting_room_repository).to receive(:find_by_id) {Dry::Monads::Some(meeting_room)}
    allow(repository).to receive(:active_booking_by_room_and_date?) {false}
  end

  describe "#call" do
    it "create meeting room booking when room is available" do
      new_booking_object = build(:meeting_room_booking, user_id: user.id, meeting_room_id: meeting_room.id)

      expect(repository).to receive(:new).with(input.merge(status: MeetingRoomBookings::Statuses::BOOKED)) {new_booking_object}

      result = operation.call(input)
      expect(result).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when params are invalids" do
      result = operation.call({})
      expect(result).to be_instance_of(Dry::Monads::Failure)
      expect(result.failure).to eq({:type=>:input_validation_error,
                                    :messages=>{:user_id=>["user_id is missing"],
                                                :meeting_room_id=>["meeting_room_id is missing"],
                                                :booked_starts_at=>["booked_starts_at is missing"],
                                                :booked_ends_at=>["booked_ends_at is missing"]}
                                   })
    end
    it "fails when booked datetime format is not allowed" do
      result = operation.call(input.merge(booked_starts_at: "2021-09-29 10:00"))
      expect(result).to be_instance_of(Dry::Monads::Failure)
      expect(result.failure).to eq({:type=>:input_validation_error, :messages=>{:booked_starts_at=>["booked_starts_at is in invalid format"] }})
    end
    it "fails when meeting room does not belongs to user's company" do
      allow(meeting_room_repository).to receive(:find_by_id) {Dry::Monads::Some(meeting_room_external)}
      result = operation.call(input.merge(meeting_room_id: meeting_room_external.id))
      expect(result).to be_instance_of(Dry::Monads::Failure)
      expect(result.failure).to eq({:type=>:forbidden, :reason=> "Meeting room does not belongs to your company"})

    end
    it "fails when room is not available" do
      allow(repository).to receive(:active_booking_by_room_and_date?) {true}
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Failure)
      expect(result.failure).to eq({:type=>:unprocessable, :reason=>"Meeting room has already booked during this timeslots"})
    end
  end
end
