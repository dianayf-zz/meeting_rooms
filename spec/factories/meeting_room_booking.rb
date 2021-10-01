FactoryBot.define do
  factory :meeting_room_booking do
    user_id {1}
    meeting_room_id {1}
    status {'BOOKED'}
    created_at {Time.now}
    updated_at {Time.now}

    booked_starts__at {Time.now + 2.days}
    booked_ends__at {Time.now + 30.minutes}

    factory :ends_booking do
      status {'FINALIZED'}
    end

    initialize_with do
      new(attributes)
    end
  end
end

