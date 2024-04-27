class Show < ApplicationRecord
  belongs_to :screen
  belongs_to :movie

  has_many :bookings

  has_many :seats, as: :resource

  has_many :seats, as: :resource

  validates :screen, :movie, :booked_tickets, :show_time, presence: true

  def as_json(options = {})
    super(only: [:id, :movie_id, :screen_id, :booked_tickets, :show_date, :show_time, :booked_seat, :gold, :silver, :platinum])
  end
end
