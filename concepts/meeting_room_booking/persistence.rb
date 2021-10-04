class MeetingRoomsBooking
  def self.find_active_booking_by_room_and_date(meeting_room_id:, booked_starts_at:, booked_ends_at:)
    default_timezone = ENV["DEFAULT_TIME_ZONE"]
    booked_starts = Time.parse("#{booked_starts_at} #{default_timezone}").utc
    booked_ends = Time.parse("#{booked_ends_at} #{default_timezone}").utc

    result =
    where(meeting_room_id: meeting_room_id)
    .where(status: MeetingRoomBookings::Statuses::BOOKED)
    .where(booked_starts_at = booked_starts)
    .where(booked_ends_at = booked_ends )
    .all

    result.empty? ? Dry::Monads::None() : Dry::Monads::Maybe(result)
  end
end
