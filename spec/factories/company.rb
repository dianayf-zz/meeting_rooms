FactoryBot.define do
  factory :company do
    name {"my company"}
    created_at {Time.now}
    updated_at {Time.now}

    initialize_with do
      new(attributes)
    end
  end
end

