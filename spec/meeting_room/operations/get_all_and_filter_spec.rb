RSpec.describe MeetingRooms::GetAllAndFilter do
  let(:company) {build(:company)}
  let(:meeting_room) {build(:meeting_room)}
  let(:repository) {double("MeetingRoom")}
  let(:company_repository) {double("Company")}

  let(:operation) do
    described_class.new(
      repository: repository,
      company_repository: company_repository
    )
  end

  let(:input) do
    {
     company_id: 1,
    }
  end

  before do
    allow(company_repository).to receive(:find_by_id) {Dry::Monads::Some(company)}
    allow(repository).to receive(:find_meeting_room_by_company_id) {[meeting_room]}
  end

  describe "#call" do
    it "get meeting room for given company" do
      result = operation.call(input)
      expect(result).to be_instance_of(Dry::Monads::Success)
    end
    it "fails when there is not any company with given id" do
      allow(company_repository).to receive(:find_by_id) {Dry::Monads::None()}

      result = operation.call({company_id: 2})
      expect(result).to be_instance_of(Dry::Monads::Failure)
      expect(result.failure).to eq({:type=>:not_found, :reason => "Company with ID: 2 not found"})
    end
  end
end
