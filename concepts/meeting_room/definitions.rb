class MeetingRoom < Hanami::Entity
  attributes do
    attribute :id, Types::Strict::Int
    attribute :max_capacity, Types::Strict::Int
    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
    attribute :company_id, Types::Strict::Int
  end
end

