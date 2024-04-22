class Payment < ApplicationRecord
  belongs_to :booking

  validates :booking_id, :status, :payment, :payment_type, presence: true

  def as_json(options = {})
    super(only: [:id, :booking_id, :status, :payment, :payment_type])
  end
end
