class Movie < ApplicationRecord
  has_many :shows

  validates :name, presence: true

  def as_json(options = {})
    super(only: [:id, :name, :release_date, :genre, :is_active])
  end
end
