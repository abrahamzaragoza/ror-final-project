# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authorize!, only: [:index]
  before_action :set_team, only: [:team]
  before_action :able_to_get_free_trial, only: [:free_trial]
  grant(
    user: %i[index team],
    manager: :all
  )

  def index
    @plans = Plan.all
  end

  def free_trial
    @plans = Plan.all
  end

  def team; end

  private

  def set_team
    @team = current_user.return_manager_team
  end

  def able_to_get_free_trial
    if current_user.stripe_id.blank?
      flash_and_redirect_to(:alert, 'You must add a payment method', user_path(current_user))
    elsif current_user.free_trial_expired
      flash_and_redirect_to(:alert, 'Your have already used your free trial period', root_path)
    end
  end
end
