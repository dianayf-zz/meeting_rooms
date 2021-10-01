FactoryBot.define do
  factory :meeting_room do
    max_capacity {5}
    created_at {Time.now}
    updated_at {Time.now}
    company_id {1}

    initialize_with do
      new(attributes)
    end
  end
  
end

