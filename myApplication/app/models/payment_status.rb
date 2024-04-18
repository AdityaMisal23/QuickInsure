class PaymentStatus < ApplicationRecord
  belongs_to :booking_details

  validates :booking_details, presence: true
  validates :status, presence: true
  validates :payment, presence: true
end
