class Show < ApplicationRecord
  belongs_to :screen
  belongs_to :movie

  has_many :bookings

  validates :screen, :movie, :ticket_price_ordinary, :ticket_price_premium, :booked_tickets, :show_time, presence: true

  def as_json(options = {})
    super(only: [:id, :movie, :ticket_price_ordinary, :ticket_price_premium, :booked_tickets, :show_date, :show_time, :booked_seat])
  end
end
