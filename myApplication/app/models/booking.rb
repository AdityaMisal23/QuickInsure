class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  # serialize :seats, Hash

  def as_json(options = {})
    super(only: [:user_id, :show_id, :seats])
  end
end
