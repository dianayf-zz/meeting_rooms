class MeetingRoomBooking < Sequel::Model

  def self.active_booking_by_room_and_date?(meeting_room_id:, booked_starts_at:, booked_ends_at:)
    where(meeting_room_id: meeting_room_id)
    .where(status: MeetingRoomBookings::Statuses::BOOKED)
    .where(booked_starts_at => booked_starts_at)
    .where(booked_ends_at <= booked_ends_at )
    .all
    .count > 0
  end

end
