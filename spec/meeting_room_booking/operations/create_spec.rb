RSpec.describe MeetingRoomBooking::Create do
  let(:company) {build(:company)}
  let(:user) {build(:user)}

  let(:operation) do
    described_class.new
  end

  let(:input) do
    described_class.new
  end

  describe "#call" do
    it "create meeting room booking when room is available" do
      result = operation.call(input)
      expect(result ).to be_instance_of(Dry::Monads::Success)
    end
  end
end
