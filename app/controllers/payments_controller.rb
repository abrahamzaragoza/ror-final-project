# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_stripe_service, :set_user, only: [:create] # don't do this
  rescue_from Stripe::StripeError, with: :stripe_error_method
  grant(
    manager: :all,
    admin: :all
  )

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.user_id = current_user.id
    @stripe_customer = @stripe_service.find_or_create_customer(@user)
    @card = @stripe_service.create_stripe_card(params, @user)
    @payment.card_id = @card.id
    if @payment.save
      flash_and_redirect_to(:notice, 'You have successfully added a payment method.', root_path)
    else
      flash_and_render(:alert, 'Something went wrong with your petition.', :new)
    end
  end

  private

  def payment_params
    params.require(:payment).permit(%i[card_number card_cvv card_expires_month card_expires_year])
  end

  def set_stripe_service
    @stripe_service = StripeService.new
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def stripe_error_method(exception)
    flash_and_render(:alert, exception.message.to_s, :new) # Are you showing the direct error to the user? Wouldn't it be better to parse it. 
  end
end
