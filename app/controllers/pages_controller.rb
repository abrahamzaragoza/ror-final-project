# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authorize!, only: [:index]
  before_action :set_team, only: [:team] # don't do this, there's only one method using it. what's the use? 
  before_action :able_to_get_free_trial, only: [:free_trial] # now, this is an example of where to use a filter.
  grant(
    user: %i[index team],
    manager: :all
  )

  # repetitive action right here
  # could have used a filter 
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
