FactoryBot.define do
  factory :meeting_room do
    company_id {1}
    max_capacity {5}
    created_at {Time.now}
    updated_at {Time.now}

    initialize_with do
      new(attributes)
    end
  end
  
end

