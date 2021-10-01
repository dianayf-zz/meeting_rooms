class Company < Hanami::Entity
  attributes do
    attribute :id, Types::Strict::Int
    attribute :name, Types::Time
  end
end

