# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :restrict_access
  grant(
    user: :all
  )
  def show
    @user = User.find(params[:id])
    if @user.stripe_subscription_id.present?
      @user_plan = UserPlan.find(@user.plan.id)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def restrict_access
    return if current_user.id == params[:id].to_i

    flash_and_redirect_to(:alert, 'You can only enter you own profile', root_path)
  end
end
