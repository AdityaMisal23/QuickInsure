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
    @payment = Payment.find_by(booking_id: params[:booking_id])
    if @payment
      render json: @payment
    else
      render json: { message: "Unable to get payment details" }
    end
  end

  private

  def payment_params
    params.permit(:booking_id, :payment, :status, :payment_type)
  end
end
