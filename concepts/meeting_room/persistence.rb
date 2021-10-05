class MeetingRoom < Sequel::Model
  one_to_many :meeting_room_bookings

  def self.find_by_id(id)
    Dry::Monads::Maybe(where(id: id).first)
  end

  def self.find_meeting_room_by_company_id(company_id:)
    where(company_id: company_id).all.to_a
  end
end
