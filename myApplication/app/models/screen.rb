class Screen < ApplicationRecord
  belongs_to :theater
  has_many :shows

  validates :name, :theater, presence: true

  def as_json(options = {})
    super(only: [:id, :theater_id, :name, :number_of_seats, :active])
  end
end
