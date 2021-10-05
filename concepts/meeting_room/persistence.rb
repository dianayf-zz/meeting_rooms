class MeetingRoom < Sequel::Model
  many_to_one :company_id

  def self.find_by_id(id)
    Dry::Monads::Maybe(where(id: id).first)
  end

  def self.find_by_id(id)
    Dry::Monads::Maybe(where(id: id).first)
  end

  def self.find_meeting_room_by_company_id(company_id:)
    where(company_id: company_id).all.to_a
  end

  def self.active_booking_by_company_id(company_id:)
  end
end
