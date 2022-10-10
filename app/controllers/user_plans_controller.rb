# frozen_string_literal: true

class UserPlansController < ApplicationController
  before_action :set_stripe_service
  before_action :validate_user_has_no_subscription, only: [:create]
  grant(
    manager: :all,
    admin: :all
  )

  def create
    @user_plan = UserPlan.new(user_plan_params)
    @subscription = @stripe_service.create_subscription(current_user, Plan.find(params[:user_plan][:plan_id]))
    if @user_plan.save
      update_user_plan_data(@user_plan)
      flash_and_redirect_to(:notice, 'You have succesfully subscribed.', user_path(current_user))
    else
      flash_and_redirect_to(:alert, 'Something went worng.', free_trial_path)
    end
  end

  def destroy
    @stripe_service.cancel_subscription(current_user)
    @user_plan = UserPlan.find(params[:id])
    @user_plan.destroy
    flash_and_redirect_to(:notice, 'You have succesfully canceled your subscription.', user_path(current_user))
  end

  private

  def user_plan_params
    params.require(:user_plan).permit(%i[user_id plan_id])
  end

  def set_stripe_service
    @stripe_service = StripeService.new
  end

  def update_user_plan_data(user_plan)
    user = User.find(user_plan.user_id)
    subscription = Stripe::Subscription.retrieve(user.stripe_subscription_id)
    user_plan.update(
      status: subscription.status,
      current_period_end: subscription.current_period_end,
      current_period_start: subscription.current_period_start,
      start_date: subscription.start_date,
      trial_end: subscription.trial_end
    )
  end

  def validate_user_has_no_subscription
    if current_user.stripe_subscription_id.present?
      flash_and_redirect_to(:alert, 'You can only have one plan subscription at a time.', root_path)
    end
  end
end
