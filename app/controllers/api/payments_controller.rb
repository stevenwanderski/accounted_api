class Api::PaymentsController < ApplicationController
  # GET /payments
  def index
    payments = Payment.all
    render json: payments
  end

  # POST /payments
  def create
    payment = Payment.new(payment_params)
    if payment.save
      render json: payment, status: :created
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /payments/:id
  def show
    payment = Payment.find(params[:id])
    render json: payment
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  # PUT /payments/:id
  def update
    payment = Payment.find(params[:id])
    if payment.update(payment_params)
      render json: payment
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  # DELETE /payments/:id
  def destroy
    payment = Payment.find(params[:id])
    payment.destroy
    render json: payment
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :not_found
  end

  private

  def payment_params
    params.require(:payment).permit(:amount_in_cents, :client_id, :note, :payment_type)
  end
end