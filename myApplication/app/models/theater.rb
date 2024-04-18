class Theater < ApplicationRecord
  belongs_to :user

  has_many :screens

  belongs_to :location

  validates :user_id, presence: true
  validates :theater_name, presence: true
  validates :theater_address, presence: true
  validates :location_id, presence: true
  validates :pincode, format: { with: /\A\d{6}\z/, message: "Wrong pincode format" }

  def as_json(options = {})
    super(only: [:id, :theater_name, :theater_address, :location, :pincode])
  end
end
