# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authorize!
  before_action :set_team, only: [:team]

  def index
    @plans = Plan.all
  end

  def about; end

  def team; end

  private

  def set_team
    @team = current_user.return_manager_team
  end
end
