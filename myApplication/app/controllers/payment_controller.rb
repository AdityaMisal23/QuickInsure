class PaymentController < ApplicationController
  def index
    @payments = Payment.all
    render json: @payments
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      render json: { message: "Payment details added" }
    else
      render json: { messagee: "Failed" }
    end
  end

  def get_payment_details
    @payment = Payment.find_by(bookings_id: params[:booking_id])
    if @payment
      render json: @payment
    else
      render json: { message: "Unable to get payment details" }
    end
  end

  # id | bookings_id | payment | status | payment_type | created_at | updated_at
  def payment_params
    params.permit(:booking_id, :payment, :status, :payment_type)
  end
end
