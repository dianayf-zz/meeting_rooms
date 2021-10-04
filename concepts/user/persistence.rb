class User
  def self.find_by_id(id)
    Dry::Monads::Maybe(where(id: id).first)
  end
end
