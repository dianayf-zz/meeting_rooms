FactoryBot.define do
  factory :user do
    name { "Diana"}
    company_id { 1}
    created_at {Time.now}
    updated_at {Time.now}

    initialize_with do
      new(attributes)
    end
  end
end
