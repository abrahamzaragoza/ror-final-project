# frozen_string_literal: true

class UserPlansController < ApplicationController
  before_action :set_stripe_service
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
      flash_and_redirect_to(:notice, 'You have succesfully subscribed.', free_trial_path)
    end
  end

  def destroy
    @user_plan = UserPlan.find(params[:id])
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
end
