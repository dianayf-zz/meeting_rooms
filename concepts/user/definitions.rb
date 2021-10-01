class User < Hanami::Entity
  attributes do
    attribute :id, Types::Strict::Int
    attribute :name, Types::Time
    attribute :company_id, Types::Strict::Int
  end
end

