FactoryBot.define do
  factory :meeting_room_booking do
    user_id {1}
    meeting_room_id {1}
    status {'BOOKED'}
    created_at {Time.now}
    updated_at {Time.now}

    booked_starts_at {"2021-09-29 10:30:00"}
    booked_ends_at {"2021-09-29 10:40:00"}

    factory :ends_booking do
      status {'FINALIZED'}
    end

    initialize_with do
      new(attributes)
    end
  end
end

