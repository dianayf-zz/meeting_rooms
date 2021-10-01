RSpec.describe MeetingRoomBooking::Create do
  let(:company) {build(:company)}
  let(:user) {build(:user)}

  let(:operation) do
    described_class.new
  end

  describe "#call" do
    it "create meeting room booking when room is available" do
      expect(repository_double)
        .to receive(:get_all_transactions_by_partial_id)
        .with(
          id: input.fetch(:id),
          page: input.fetch(:page),
          page_size: input.fetch(:page_size),
          start_date: input.fetch(:start_date),
          end_date: input.fetch(:end_date)
        )
      result = operation.call(input)
      expect(result 
    end
  end
end
