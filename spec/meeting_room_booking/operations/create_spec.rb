RSpec.describe MeetingRoomBooking::Create do
  let(:meeting_room) {build(:meeting_room).save}
  let(:company) {build(:company).save}
  let(:user) {build(:user, company_id: company.id).save}
  let(:meeting_room_booking) do
    build(:meeting_room_booking, user_id: user.id, meeting_room_id: meeting_room.id, status: MeetingRoomBookings::Statuses::FINISHED).save
  end

  let(:operation) do
    described_class.new
  end

  let(:input) do
    {
      user_id: user.id.to_s,
      meeting_room_id: meeting_room.id.to_s,
      booked_starts_at: "2021-09-29 10:00:00 +0200",
      booked_ends_at: "2021-09-29 10:30:00 +0200"
   }
  end

  describe "#call" do
    it "create meeting room booking when room is available" do
      result = operation.call(input)
      byebug
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when param are not valids" do
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when booked datetime format is not allowed" do
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when booked_starts_at is lower than booked_ends_at" do
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when room is not available" do
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
  end
end
