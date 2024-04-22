class Location < ApplicationRecord
  has_many :theaters

  def as_json(options = {})
    super(only: [:id, :name])
  end
end
