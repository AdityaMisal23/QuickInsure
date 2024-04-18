class ChangeBookingDetailsIdToBookingDetailIdInPaymentStatuses < ActiveRecord::Migration[7.1]
  def change
    rename_column :payment_statuses, :booking_details_id, :booking_detail_id

  end
end
