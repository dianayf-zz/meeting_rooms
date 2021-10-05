class Company < Sequel::Model
  one_to_many :meeting_rooms

  def self.find_by_id(id)
    Dry::Monads::Maybe(where(id: id).first)
  end
end
